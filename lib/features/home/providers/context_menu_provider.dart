import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';

@immutable
class ContextMenuState {
  final UiOngoing? item;
  final LayerLink? link;

  const ContextMenuState({this.item, this.link});

  bool get isVisible => item != null && link != null;
}

class ContextMenuNotifier extends StateNotifier<ContextMenuState> {
  ContextMenuNotifier() : super(const ContextMenuState());

  void show(UiOngoing item, LayerLink link) {
    state = ContextMenuState(item: item, link: link);
  }

  void hide() {
    state = const ContextMenuState();
  }
}

final contextMenuProvider =
    StateNotifierProvider<ContextMenuNotifier, ContextMenuState>(
      (ref) => ContextMenuNotifier(),
    );
