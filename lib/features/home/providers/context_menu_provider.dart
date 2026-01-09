import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';

enum ContextMenuSide { left, right, bottom }

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
    final size = MediaQuery.of(context).size;

    const menuWidth = 180.0;
    const menuHeight = 2 * 44.0 + 8; // 2 button + gap
    const safeMargin = 16.0;

    final spaceRight = size.width - cardRect.right - safeMargin;
    final spaceLeft = cardRect.left - safeMargin;
    final spaceBottom = size.height - cardRect.bottom - safeMargin;

    ContextMenuSide side;

    if (spaceRight >= menuWidth) {
      side = ContextMenuSide.right;
    } else if (spaceLeft >= menuWidth) {
      side = ContextMenuSide.left;
    } else if (spaceBottom >= menuHeight) {
      side = ContextMenuSide.bottom;
    } else {
      side = ContextMenuSide.right;
    }

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
