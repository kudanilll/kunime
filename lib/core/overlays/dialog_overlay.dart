import 'package:flutter/material.dart';
import 'package:kunime/core/overlays/blur_overlay.dart';
import 'package:kunime/core/themes/app_colors.dart';

enum DialogActionStyle { primary, destructive, neutral }

class DialogAction {
  final String label;
  final VoidCallback onTap;
  final DialogActionStyle style;

  const DialogAction({
    required this.label,
    required this.onTap,
    this.style = DialogActionStyle.primary,
  });
}

class DialogOverlay {
  static void show(
    BuildContext context, {
    required String title,
    String? message,
    required List<DialogAction> actions,
    bool dismissOnTapOutside = true,
  }) {
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) => BlurOverlay(
        onDismiss: dismissOnTapOutside ? () => entry.remove() : null,
        child: Center(
          child: _DialogCard(
            title: title,
            message: message,
            actions: actions,
            onDismiss: () => entry.remove(),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(entry);
  }
}

class _DialogCard extends StatelessWidget {
  final String title;
  final String? message;
  final List<DialogAction> actions;
  final VoidCallback onDismiss;

  const _DialogCard({
    required this.title,
    required this.actions,
    required this.onDismiss,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 300,
        padding: const EdgeInsets.fromLTRB(0, 22, 0, 0),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppColors.white.withValues(alpha: 0.10),
              blurRadius: 40,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
            if (message != null) ...[
              const SizedBox(height: 8),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.neutral400,
                ),
              ),
            ],
            const SizedBox(height: 22),
            _DialogActions(actions: actions, onDismiss: onDismiss),
          ],
        ),
      ),
    );
  }
}

class _DialogActions extends StatelessWidget {
  final List<DialogAction> actions;
  final VoidCallback onDismiss;

  const _DialogActions({required this.actions, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    if (actions.length == 1) {
      return _ActionZone(action: actions.first, onDismiss: onDismiss);
    }

    return Row(
      children: [
        Expanded(
          child: _ActionZone(
            action: actions[0],
            onDismiss: onDismiss,
            showRightDivider: true,
          ),
        ),
        Expanded(
          child: _ActionZone(action: actions[1], onDismiss: onDismiss),
        ),
      ],
    );
  }
}

class _ActionZone extends StatelessWidget {
  final DialogAction action;
  final VoidCallback onDismiss;
  final bool showRightDivider;

  const _ActionZone({
    required this.action,
    required this.onDismiss,
    this.showRightDivider = false,
  });

  Color get _textColor {
    switch (action.style) {
      case DialogActionStyle.destructive:
        return AppColors.error;
      case DialogActionStyle.neutral:
        return AppColors.onSecondary;
      case DialogActionStyle.primary:
        return AppColors.onSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        action.onTap();
        onDismiss();
      },
      child: Container(
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: showRightDivider
              ? Border(
                  right: BorderSide(
                    color: AppColors.white.withValues(alpha: 0.25),
                    width: 0.5,
                  ),
                  top: BorderSide(
                    color: AppColors.white.withValues(alpha: 0.25),
                    width: 0.5,
                  ),
                )
              : Border(
                  top: BorderSide(
                    color: AppColors.white.withValues(alpha: 0.25),
                    width: 0.5,
                  ),
                ),
        ),
        child: Text(
          action.label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: _textColor,
          ),
        ),
      ),
    );
  }
}
