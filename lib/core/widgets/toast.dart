import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kunime/core/themes/app_colors.dart';

enum ToastType { info, success, error, warning }

class Toast {
  static OverlayEntry? _entry;

  static void show(
    BuildContext context, {
    required String title,
    required String message,
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 3),
    bool showCloseButton = false,
  }) {
    _entry?.remove();
    _entry = OverlayEntry(
      builder: (_) => _ToastOverlay(
        title: title,
        message: message,
        type: type,
        duration: duration,
        showCloseButton: showCloseButton,
        onDismiss: hide,
      ),
    );
    Overlay.of(context, rootOverlay: true).insert(_entry!);
  }

  static void hide() {
    _entry?.remove();
    _entry = null;
  }
}

class _ToastOverlay extends StatefulWidget {
  final String title;
  final String message;
  final ToastType type;
  final Duration duration;
  final bool showCloseButton;
  final VoidCallback onDismiss;

  const _ToastOverlay({
    required this.title,
    required this.message,
    required this.type,
    required this.duration,
    required this.showCloseButton,
    required this.onDismiss,
  });

  @override
  State<_ToastOverlay> createState() => _ToastOverlayState();
}

class _ToastOverlayState extends State<_ToastOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;

  Timer? _dismissTimer;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _scale = CurvedAnimation(
      parent: _controller,
      curve: Curves.linearToEaseOut,
    );
    _opacity = CurvedAnimation(
      parent: _controller,
      curve: Curves.linearToEaseOut,
    );
    _controller.forward();
    _dismissTimer = Timer(widget.duration, _dismiss);
  }

  Future<void> _dismiss() async {
    if (!mounted || _isDisposed) return;
    _dismissTimer?.cancel();
    try {
      await _controller.reverse();
    } catch (_) {}
    if (mounted) {
      widget.onDismiss();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _dismissTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = _ToastStyle.from(widget.type);
    return Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      left: 16,
      right: 16,
      child: FadeTransition(
        opacity: _opacity,
        child: ScaleTransition(
          scale: _scale,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: config.background,
                borderRadius: BorderRadius.circular(96),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: config.iconBg,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(config.icon, size: 28, color: config.iconColor),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          widget.message,
                          style: const TextStyle(
                            color: AppColors.neutral200,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.showCloseButton) ...[
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: _dismiss,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 18,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ToastStyle {
  final Color background;
  final Color iconBg;
  final Color iconColor;
  final IconData icon;

  _ToastStyle({
    required this.background,
    required this.iconBg,
    required this.iconColor,
    required this.icon,
  });

  factory _ToastStyle.from(ToastType type) {
    switch (type) {
      case ToastType.success:
        return _ToastStyle(
          background: AppColors.green900,
          iconBg: AppColors.green700,
          iconColor: Colors.white,
          icon: Icons.check,
        );
      case ToastType.error:
        return _ToastStyle(
          background: AppColors.red900,
          iconBg: AppColors.red700,
          iconColor: Colors.white,
          icon: Icons.close,
        );
      case ToastType.warning:
        return _ToastStyle(
          background: AppColors.yellow900,
          iconBg: AppColors.yellow700,
          iconColor: Colors.white,
          icon: Icons.warning_amber_rounded,
        );
      case ToastType.info:
        return _ToastStyle(
          background: AppColors.blue900,
          iconBg: AppColors.blue700,
          iconColor: Colors.white,
          icon: Icons.info_outline,
        );
    }
  }
}
