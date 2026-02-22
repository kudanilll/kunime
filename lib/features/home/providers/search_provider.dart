import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/legacy.dart';
import 'package:kunime/features/home/models/search/model.dart';
import 'package:kunime/features/home/providers/home_provider.dart';
import 'package:kunime/features/home/providers/search_state.dart';
import 'package:kunime/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

final searchProvider = StateNotifierProvider<SearchNotifier, SearchState>(
  (ref) => SearchNotifier(ref.read(apiServiceProvider)),
);

class SearchNotifier extends StateNotifier<SearchState> {
  static const _historyKey = 'search_history_v1';

  SearchNotifier(this._api) : super(SearchState.initial()) {
    _loadHistory();
  }

  final ApiService _api;
  Timer? _debounce;

  void onQueryChanged(String value) {
    state = state.copyWith(rawQuery: value, status: SearchStatus.idle);

    _debounce?.cancel();

    if (value.trim().isEmpty) {
      state = SearchState.initial();
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 550), () {
      final normalized = _normalizeQuery(value);
      _search(normalized);
    });
  }

  Future<void> addToHistory(SearchAnimeModel anime) async {
    final updated = [
      anime,
      ...state.history.where((h) => h.endpoint != anime.endpoint),
    ].take(10).toList();

    state = state.copyWith(history: updated);
    await _saveHistory(updated);
  }

  Future<void> removeHistory(SearchAnimeModel anime) async {
    final updated = state.history
        .where((h) => h.endpoint != anime.endpoint)
        .toList();

    state = state.copyWith(history: updated);
    await _saveHistory(updated);
  }

  void clear() {
    _debounce?.cancel();
    state = state.copyWith(
      rawQuery: '',
      debouncedQuery: '',
      status: SearchStatus.idle,
      results: [],
      error: null,
    );
  }

  // NO-OP
  // TODO: Implement load more
  Future<void> loadMore() async {}

  String _normalizeQuery(String input) {
    return input.trim().toLowerCase().replaceAll(RegExp(r'\s+'), '+');
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_historyKey) ?? [];

    final items = raw
        .map((e) => SearchAnimeModel.fromJson(jsonDecode(e)))
        .toList();

    state = state.copyWith(history: items);
  }

  Future<void> _saveHistory(List<SearchAnimeModel> items) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = items.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_historyKey, encoded);
  }

  Future<void> _search(String query) async {
    state = state.copyWith(
      debouncedQuery: query,
      status: SearchStatus.loading,
      error: null,
    );

    try {
      final res = await _api.searchAnime(query);

      if (res.data.isEmpty) {
        state = state.copyWith(status: SearchStatus.empty, results: const []);
      } else {
        state = state.copyWith(status: SearchStatus.success, results: res.data);
      }
    } catch (e) {
      state = state.copyWith(status: SearchStatus.error, error: e.toString());
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
