import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/features/home/application/context_menu_state.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';

class ContextMenuController extends Notifier<ContextMenuState> {
  @override
  ContextMenuState build() => const ContextMenuState();

  void show(
    UiOngoing item,
    LayerLink link,
    Rect cardRect,
    BuildContext context,
  ) {
    final size = MediaQuery.of(context).size;

    const menuWidth = 180.0;
    const menuHeight = 2 * 44.0 + 8;
    const safeMargin = 16.0;

    final spaceRight = size.width - cardRect.right - safeMargin;
    final spaceLeft = cardRect.left - safeMargin;
    final spaceBottom = size.height - cardRect.bottom - safeMargin;

    final side = switch ((spaceRight, spaceLeft, spaceBottom)) {
      (>= menuWidth, _, _) => ContextMenuSide.right,
      (_, >= menuWidth, _) => ContextMenuSide.left,
      (_, _, >= menuHeight) => ContextMenuSide.bottom,
      _ => ContextMenuSide.right,
    };

    state = ContextMenuState(item: item, link: link, visible: true, side: side);
  }

  void hide() {
    state = const ContextMenuState();
  }
}

final homeContextMenuProvider =
    NotifierProvider<ContextMenuController, ContextMenuState>(
      ContextMenuController.new,
    );
