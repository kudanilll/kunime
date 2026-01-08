import 'dart:ui';

import 'package:flutter_riverpod/legacy.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';

import 'home_context_menu_state.dart';

final homeContextMenuProvider =
    StateNotifierProvider<HomeContextMenuController, HomeContextMenuState>(
      (ref) => HomeContextMenuController(),
    );

class HomeContextMenuController extends StateNotifier<HomeContextMenuState> {
  HomeContextMenuController() : super(HomeContextMenuState.empty);

  void open({required UiOngoing item, required Rect rect}) {
    state = HomeContextMenuState(item: item, rect: rect);
  }

  void close() {
    state = HomeContextMenuState.empty;
  }
}
