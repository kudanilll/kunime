import 'dart:async';
import 'package:flutter_riverpod/legacy.dart';

final searchProvider = StateNotifierProvider<SearchNotifier, SearchState>(
  (ref) => SearchNotifier(),
);

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier() : super(const SearchState());

  Timer? _debounce;

  void onQueryChanged(String value) {
    state = state.copyWith(rawQuery: value);

    _debounce?.cancel();

    if (value.trim().isEmpty) {
      state = state.copyWith(debouncedQuery: '');
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 550), () {
      final normalized = _normalizeQuery(value);

      state = state.copyWith(debouncedQuery: normalized, isLoading: true);

      // TODO: Implement search
      // _search(normalized);
    });
  }

  void clear() {
    _debounce?.cancel();
    state = const SearchState();
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

class SearchState {
  final String rawQuery;
  final String debouncedQuery;
  final bool isLoading;

  const SearchState({
    this.rawQuery = '',
    this.debouncedQuery = '',
    this.isLoading = false,
  });

  bool get isEmpty => rawQuery.isEmpty;

  SearchState copyWith({
    String? rawQuery,
    String? debouncedQuery,
    bool? isLoading,
  }) {
    return SearchState(
      rawQuery: rawQuery ?? this.rawQuery,
      debouncedQuery: debouncedQuery ?? this.debouncedQuery,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
