import 'dart:async';
import 'package:flutter_riverpod/legacy.dart';
import 'package:kunime/features/home/providers/home_provider.dart';
import 'package:kunime/features/home/providers/search_state.dart';
import 'package:kunime/services/api.dart';

final searchProvider = StateNotifierProvider<SearchNotifier, SearchState>(
  (ref) => SearchNotifier(ref.read(apiServiceProvider)),
);

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier(this._api) : super(SearchState.initial());

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

  void clear() {
    _debounce?.cancel();
    state = SearchState.initial();
  }

  String _normalizeQuery(String input) {
    return input.trim().toLowerCase().replaceAll(RegExp(r'\s+'), '+');
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
