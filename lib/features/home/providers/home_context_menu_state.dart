import 'dart:ui';

import 'package:kunime/features/home/models/home_ui_models.dart';

class HomeContextMenuState {
  final UiOngoing? item;
  final Rect? rect;

  const HomeContextMenuState({this.item, this.rect});

  bool get isActive => item != null && rect != null;

  HomeContextMenuState copyWith({UiOngoing? item, Rect? rect}) {
    return HomeContextMenuState(item: item, rect: rect);
  }

  static const empty = HomeContextMenuState();
}
