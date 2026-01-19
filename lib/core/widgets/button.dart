import 'package:flutter/material.dart';
import 'package:kunime/core/themes/app_tokens.dart';

enum KButtonVariant { primary, secondary, danger, ghost }

class KButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;

  final bool fullWidth;
  final KButtonVariant variant;
  final double height;

  const KButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.fullWidth = false,
    this.variant = KButtonVariant.primary,
    this.height = 44,
  });

  bool get _enabled => onPressed != null;

  @override
  Widget build(BuildContext context) {
    final style = _KButtonStyle.fromVariant(variant, _enabled);

    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 120),
        opacity: _enabled ? 1 : 0.48,
        child: Container(
          height: height,
          width: fullWidth ? double.infinity : null,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: style.background,
            borderRadius: BorderRadius.circular(96),
            border: style.border,
          ),
          child: Row(
            mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: style.foreground),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: TextStyle(
                  color: style.foreground,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _KButtonStyle {
  final Color background;
  final Color foreground;
  final Border? border;

  _KButtonStyle({
    required this.background,
    required this.foreground,
    this.border,
  });

  factory _KButtonStyle.fromVariant(KButtonVariant variant, bool enabled) {
    switch (variant) {
      case KButtonVariant.primary:
        return _KButtonStyle(
          background: enabled ? AppTokens.primary : AppTokens.primaryContainer,
          foreground: AppTokens.onPrimary,
        );

      case KButtonVariant.secondary:
        return _KButtonStyle(
          background: AppTokens.secondary,
          foreground: AppTokens.onSecondary,
        );

      case KButtonVariant.danger:
        return _KButtonStyle(
          background: AppTokens.error,
          foreground: AppTokens.onSemantic,
        );

      case KButtonVariant.ghost:
        return _KButtonStyle(
          background: Colors.transparent,
          foreground: AppTokens.primary,
          border: Border.all(color: AppTokens.primaryContainer, width: 1),
        );
    }
  }
}
