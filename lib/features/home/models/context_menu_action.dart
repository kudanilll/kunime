import 'package:flutter/material.dart';

class ContextMenuAction {
  final Widget icon;
  final String label;
  final VoidCallback onTap;

  const ContextMenuAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}
