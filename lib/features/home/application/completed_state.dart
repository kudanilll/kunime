import 'package:kunime/features/home/models/home_ui_models.dart';

enum CompletedStatus { initialLoading, success, empty, error }

class CompletedState {
  const CompletedState({
    required this.status,
    required this.items,
    required this.currentPage,
    required this.hasNextPage,
    required this.isPageLoading,
    this.selectedLetter,
    this.errorMessage,
  });

  final CompletedStatus status;
  final List<UiCompleted> items;
  final int currentPage;
  final bool hasNextPage;
  final bool isPageLoading;
  final String? selectedLetter;
  final String? errorMessage;

  factory CompletedState.initial() {
    return const CompletedState(
      status: CompletedStatus.initialLoading,
      items: <UiCompleted>[],
      currentPage: 1,
      hasNextPage: true,
      isPageLoading: false,
    );
  }

  static const _unset = Object();

  CompletedState copyWith({
    CompletedStatus? status,
    List<UiCompleted>? items,
    int? currentPage,
    bool? hasNextPage,
    bool? isPageLoading,
    Object? selectedLetter = _unset,
    Object? errorMessage = _unset,
  }) {
    return CompletedState(
      status: status ?? this.status,
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      isPageLoading: isPageLoading ?? this.isPageLoading,
      selectedLetter: selectedLetter == _unset
          ? this.selectedLetter
          : selectedLetter as String?,
      errorMessage: errorMessage == _unset
          ? this.errorMessage
          : errorMessage as String?,
    );
  }
}
