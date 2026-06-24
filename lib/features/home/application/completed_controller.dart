import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/features/home/application/completed_state.dart';
import 'package:kunime/features/home/application/home_feed_providers.dart';

final completedControllerProvider =
    NotifierProvider<CompletedController, CompletedState>(
      CompletedController.new,
    );

class CompletedController extends Notifier<CompletedState> {
  @override
  CompletedState build() {
    return CompletedState.initial();
  }

  Future<void> loadInitial() async {
    if (state.items.isNotEmpty || state.isPageLoading) return;
    await fetchPage(1);
  }

  Future<void> fetchPage(int page) async {
    if (page < 1) return;

    final isInitialLoad = page == 1 && state.items.isEmpty;
    if (state.isPageLoading) return;

    state = state.copyWith(
      status: isInitialLoad ? CompletedStatus.initialLoading : state.status,
      isPageLoading: !isInitialLoad,
      errorMessage: null,
    );

    try {
      final items = await ref
          .read(homeRepositoryProvider)
          .fetchCompletedAnime(page: page);

      if (items.isEmpty) {
        state = state.copyWith(
          status: page == 1 ? CompletedStatus.empty : state.status,
          items: page == 1 ? const [] : state.items,
          currentPage: page == 1 ? 1 : state.currentPage,
          hasNextPage: false,
          isPageLoading: false,
          errorMessage: null,
        );
        return;
      }

      state = state.copyWith(
        status: CompletedStatus.success,
        items: items,
        currentPage: page,
        hasNextPage: true,
        isPageLoading: false,
        errorMessage: null,
      );
    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint('CompletedController.fetchPage failed: $error\n$stackTrace');
      }
      state = state.copyWith(
        status: state.items.isEmpty ? CompletedStatus.error : state.status,
        isPageLoading: false,
        errorMessage: error.toString(),
      );
    }
  }

  Future<void> fetchNextPage() async {
    if (!state.hasNextPage || state.isPageLoading) return;
    await fetchPage(state.currentPage + 1);
  }

  Future<void> fetchPreviousPage() async {
    if (state.currentPage <= 1 || state.isPageLoading) return;
    await fetchPage(state.currentPage - 1);
  }

  void selectLetter(String? letter) {
    state = state.copyWith(selectedLetter: letter);
  }

  Future<void> retry() async {
    await fetchPage(state.currentPage);
  }

  Future<void> refresh() async {
    await fetchPage(1);
  }
}
