import 'package:flutter/material.dart';

class ContextMenuAction {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ContextMenuAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}
