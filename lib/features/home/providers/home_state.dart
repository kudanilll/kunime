import 'package:flutter_riverpod/legacy.dart';
import 'package:kunime/features/home/models/home_mode.dart';

class HomeState {
  final HomeMode mode;

  const HomeState({required this.mode});

  HomeState copyWith({HomeMode? mode}) {
    return HomeState(mode: mode ?? this.mode);
  }
}

class HomeStateNotifier extends StateNotifier<HomeState> {
  HomeStateNotifier() : super(const HomeState(mode: HomeMode.ongoing));

  void setMode(HomeMode mode) {
    if (state.mode == mode) return;
    state = state.copyWith(mode: mode);
  }
}
