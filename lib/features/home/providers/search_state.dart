import 'package:kunime/features/home/models/search/model.dart';

enum SearchStatus { idle, loading, success, empty, error }

class SearchState {
  final String rawQuery;
  final String debouncedQuery;
  final SearchStatus status;
  final List<SearchAnimeModel> results;
  final String? error;

  const SearchState({
    required this.rawQuery,
    required this.debouncedQuery,
    required this.status,
    required this.results,
    this.error,
  });

  factory SearchState.initial() {
    return const SearchState(
      rawQuery: '',
      debouncedQuery: '',
      status: SearchStatus.idle,
      results: [],
    );
  }

  SearchState copyWith({
    String? rawQuery,
    String? debouncedQuery,
    SearchStatus? status,
    List<SearchAnimeModel>? results,
    String? error,
  }) {
    return SearchState(
      rawQuery: rawQuery ?? this.rawQuery,
      debouncedQuery: debouncedQuery ?? this.debouncedQuery,
      status: status ?? this.status,
      results: results ?? this.results,
      error: error,
    );
  }
}
