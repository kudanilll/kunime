import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/features/home/application/home_feed_providers.dart';
import 'package:kunime/features/home/application/search_state.dart';
import 'package:kunime/features/home/data/repositories/search_history_repository.dart';
import 'package:kunime/features/home/data/repositories/shared_preferences_search_history_repository.dart';
import 'package:kunime/features/home/models/search/model.dart';

final searchHistoryRepositoryProvider = Provider<SearchHistoryRepository>((
  ref,
) {
  return SharedPreferencesSearchHistoryRepository();
});

final searchControllerProvider =
    NotifierProvider<AnimeSearchController, SearchState>(
      AnimeSearchController.new,
    );

class AnimeSearchController extends Notifier<SearchState> {
  SearchHistoryRepository get _searchHistoryRepository =>
      ref.read(searchHistoryRepositoryProvider);

  Timer? _debounce;

  @override
  SearchState build() {
    ref.onDispose(() => _debounce?.cancel());
    _loadHistory();
    return SearchState.initial();
  }

  void onQueryChanged(String value) {
    state = state.copyWith(rawQuery: value, status: SearchStatus.idle);

    _debounce?.cancel();

    if (value.trim().isEmpty) {
      state = SearchState.initial().copyWith(history: state.history);
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 550), () {
      _search(_normalizeQuery(value));
    });
  }

  Future<void> addToHistory(SearchAnimeModel anime) async {
    final updated = [
      anime,
      ...state.history.where((item) => item.endpoint != anime.endpoint),
    ].take(10).toList(growable: false);

    state = state.copyWith(history: updated);
    await _searchHistoryRepository.save(updated);
  }

  Future<void> removeHistory(SearchAnimeModel anime) async {
    final updated = state.history
        .where((item) => item.endpoint != anime.endpoint)
        .toList(growable: false);

    state = state.copyWith(history: updated);
    await _searchHistoryRepository.save(updated);
  }

  void clear() {
    _debounce?.cancel();
    state = state.copyWith(
      rawQuery: '',
      debouncedQuery: '',
      status: SearchStatus.idle,
      results: const <SearchAnimeModel>[],
      error: null,
    );
  }

  String _normalizeQuery(String input) {
    return input.trim().toLowerCase().replaceAll(RegExp(r'\s+'), '+');
  }

  Future<void> _loadHistory() async {
    final items = await _searchHistoryRepository.load();
    state = state.copyWith(history: items);
  }

  Future<void> _search(String query) async {
    if (query == state.debouncedQuery && state.status == SearchStatus.success) {
      return;
    }

    state = state.copyWith(
      debouncedQuery: query,
      status: SearchStatus.loading,
      error: null,
    );

    try {
      final results = await ref.read(homeRepositoryProvider).searchAnime(query);

      if (results.isEmpty) {
        state = state.copyWith(
          status: SearchStatus.empty,
          results: const <SearchAnimeModel>[],
        );
        return;
      }

      state = state.copyWith(status: SearchStatus.success, results: results);
    } catch (error) {
      state = state.copyWith(
        status: SearchStatus.error,
        error: error.toString(),
      );
    }
  }
}
