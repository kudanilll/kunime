import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kunime/core/themes/app_colors.dart';

class KTextButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final Color color;
  final Color pressedColor;
  final TextStyle? style;
  final HitTestBehavior behavior;
  final EdgeInsetsGeometry padding;

  const KTextButton({
    super.key,
    required this.label,
    required this.onTap,
    this.color = AppColors.blue500,
    this.pressedColor = AppColors.blue700,
    this.style,
    this.behavior = HitTestBehavior.translucent,
    this.padding = const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
  });

  @override
  State<KTextButton> createState() => _KTextButtonState();
}

class _KTextButtonState extends State<KTextButton> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed != value) {
      HapticFeedback.selectionClick();
      setState(() => _pressed = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle =
        widget.style ??
        const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

    return GestureDetector(
      behavior: widget.behavior,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onTap,
      child: Padding(
        padding: widget.padding,
        child: Text(
          widget.label,
          style: baseStyle.copyWith(
            color: _pressed ? widget.pressedColor : widget.color,
          ),
        ),
      ),
    );
  }
}
