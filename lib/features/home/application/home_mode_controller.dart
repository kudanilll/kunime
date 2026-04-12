import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/features/home/models/home_mode.dart';

class HomeModeController extends Notifier<HomeMode> {
  @override
  HomeMode build() => HomeMode.ongoing;

  void setMode(HomeMode mode) {
    if (state == mode) return;
    state = mode;
  }
}

final homeModeProvider = NotifierProvider<HomeModeController, HomeMode>(
  HomeModeController.new,
);
