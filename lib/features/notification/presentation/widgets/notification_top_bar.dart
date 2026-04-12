import 'package:flutter/material.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/core/themes/app_tokens.dart';
import 'package:kunime/core/widgets/svg_icon.dart';

class NotificationTopBar extends StatelessWidget
    implements PreferredSizeWidget {
  final List<Map<String, String>> notifications;
  final VoidCallback onClearAllNotifications;

  const NotificationTopBar({
    super.key,
    required this.notifications,
    required this.onClearAllNotifications,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTokens.background,
              AppTokens.background.withValues(alpha: 0.9),
              Colors.transparent,
            ],
            stops: const [0.0, 0.7, 1.0],
          ),
        ),
      ),
      elevation: 0,
      title: Text(
        notifications.isEmpty
            ? 'Notifikasi'
            : 'Notifikasi (${notifications.length})',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: IconButton(
            tooltip: 'Hapus Semua Notifikasi',
            icon: SvgIcon.trash(24, AppColors.errorBadge).widget,
            onPressed: onClearAllNotifications,
          ),
        ),
      ],
    );
  }
}
