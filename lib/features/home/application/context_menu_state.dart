import 'package:flutter/material.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';

enum ContextMenuSide { left, right, bottom }

class ContextMenuState {
  const ContextMenuState({
    this.item,
    this.link,
    this.visible = false,
    this.side = ContextMenuSide.right,
  });

  final UiOngoing? item;
  final LayerLink? link;
  final bool visible;
  final ContextMenuSide side;
}
