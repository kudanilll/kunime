import 'package:flutter/material.dart';
import 'package:kunime/core/themes/app_tokens.dart';

enum KChipVariant { filled, outline }

class KChip extends StatelessWidget {
  final String label;
  final KChipVariant variant;
  final VoidCallback? onTap;
  final double fontSize;

  const KChip({
    super.key,
    required this.label,
    this.variant = KChipVariant.filled,
    this.onTap,
    this.fontSize = 12,
  });

  bool get _isClickable => onTap != null;

  @override
  Widget build(BuildContext context) {
    final chip = Container(
      padding: EdgeInsets.symmetric(
        horizontal: fontSize * 0.75,
        vertical: fontSize * 0.35,
      ),
      decoration: BoxDecoration(
        color: _backgroundColor(),
        borderRadius: BorderRadius.circular(999),
        border: variant == KChipVariant.outline
            ? Border.all(color: AppTokens.secondary, width: 1)
            : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: _textColor(),
        ),
      ),
    );

    if (!_isClickable) return chip;

    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: chip,
    );
  }

  Color _backgroundColor() {
    switch (variant) {
      case KChipVariant.filled:
        return AppTokens.secondary;
      case KChipVariant.outline:
        return Colors.transparent;
    }
  }

  Color _textColor() {
    switch (variant) {
      case KChipVariant.filled:
        return AppTokens.onSecondary;
      case KChipVariant.outline:
        return AppTokens.secondary;
    }
  }
}
