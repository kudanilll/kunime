import 'package:flutter_riverpod/legacy.dart';
import 'home_state.dart';

final homeStateProvider = StateNotifierProvider<HomeStateNotifier, HomeState>(
  (ref) => HomeStateNotifier(),
);
