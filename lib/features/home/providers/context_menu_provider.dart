import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';

enum ContextMenuSide { left, right }

class ContextMenuState {
  final UiOngoing? item;
  final LayerLink? link;
  final bool visible;
  final ContextMenuSide side;

  const ContextMenuState({
    this.item,
    this.link,
    this.visible = false,
    this.side = ContextMenuSide.right,
  });
}

class ContextMenuNotifier extends StateNotifier<ContextMenuState> {
  ContextMenuNotifier() : super(const ContextMenuState());

  void show(
    UiOngoing item,
    LayerLink link,
    Rect cardRect,
    BuildContext context,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;

    const menuWidth = 180.0;
    const safeMargin = 16.0;

    final spaceRight = screenWidth - cardRect.right - safeMargin;

    final side = spaceRight < menuWidth
        ? ContextMenuSide.left
        : ContextMenuSide.right;

    state = ContextMenuState(item: item, link: link, visible: true, side: side);
  }

  void hide() {
    state = const ContextMenuState();
  }
}

final contextMenuProvider =
    StateNotifierProvider<ContextMenuNotifier, ContextMenuState>(
      (ref) => ContextMenuNotifier(),
    );
