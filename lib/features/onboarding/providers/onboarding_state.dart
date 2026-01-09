class OnboardingState {
  final bool completed;

  const OnboardingState({this.completed = false});

  OnboardingState copyWith({bool? completed}) {
    return OnboardingState(completed: completed ?? this.completed);
  }
}
