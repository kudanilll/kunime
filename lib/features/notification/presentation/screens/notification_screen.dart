import 'package:flutter/material.dart';
import 'package:kunime/core/overlays/dialog_overlay.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/core/themes/app_tokens.dart';
import 'package:kunime/core/widgets/toast.dart';
import 'package:kunime/features/notification/presentation/widgets/notification_list.dart';
import 'package:kunime/features/notification/presentation/widgets/notification_top_bar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Dummy data
  List<Map<String, String>> notifications = [
    {
      'title': 'Episode Baru Dirilis',
      'subtitle': 'Episode 10 dari “My Hero Academia” telah tayang!',
      'time': '2 jam yang lalu',
    },
    {
      'title': 'Pemberitahuan Maintenance',
      'subtitle':
          'Server kami akan down untuk pemeliharaan malam ini pukul 22.00 WIB.',
      'time': '1 hari yang lalu',
    },
    {
      'title': 'Diskon Spesial',
      'subtitle': 'Get 20% off on premium subscriptions. Limited time offer!',
      'time': '3 hari yang lalu',
    },
    {
      'title': 'Episode Baru Dirilis',
      'subtitle': 'Episode 10 dari “My Hero Academia” telah tayang!',
      'time': '2 jam yang lalu',
    },
    {
      'title': 'Pemberitahuan Maintenance',
      'subtitle':
          'Server kami akan down untuk pemeliharaan malam ini pukul 22.00 WIB.',
      'time': '1 hari yang lalu',
    },
    {
      'title': 'Diskon Spesial',
      'subtitle': 'Get 20% off on premium subscriptions. Limited time offer!',
      'time': '3 hari yang lalu',
    },
    {
      'title': 'Episode Baru Dirilis',
      'subtitle': 'Episode 10 dari “My Hero Academia” telah tayang!',
      'time': '2 jam yang lalu',
    },
    {
      'title': 'Pemberitahuan Maintenance',
      'subtitle':
          'Server kami akan down untuk pemeliharaan malam ini pukul 22.00 WIB.',
      'time': '1 hari yang lalu',
    },
    {
      'title': 'Diskon Spesial',
      'subtitle': 'Get 20% off on premium subscriptions. Limited time offer!',
      'time': '3 hari yang lalu',
    },
    {
      'title': 'Episode Baru Dirilis',
      'subtitle': 'Episode 10 dari “My Hero Academia” telah tayang!',
      'time': '2 jam yang lalu',
    },
    {
      'title': 'Pemberitahuan Maintenance',
      'subtitle':
          'Server kami akan down untuk pemeliharaan malam ini pukul 22.00 WIB.',
      'time': '1 hari yang lalu',
    },
    {
      'title': 'Diskon Spesial',
      'subtitle': 'Get 20% off on premium subscriptions. Limited time offer!',
      'time': '3 hari yang lalu',
    },
    {
      'title': 'Episode Baru Dirilis',
      'subtitle': 'Episode 10 dari “My Hero Academia” telah tayang!',
      'time': '2 jam yang lalu',
    },
    {
      'title': 'Pemberitahuan Maintenance',
      'subtitle':
          'Server kami akan down untuk pemeliharaan malam ini pukul 22.00 WIB.',
      'time': '1 hari yang lalu',
    },
    {
      'title': 'Diskon Spesial',
      'subtitle': 'Get 20% off on premium subscriptions. Limited time offer!',
      'time': '3 hari yang lalu',
    },
  ];

  void _clearAllNotifications() {
    if (notifications.isEmpty) return;
    DialogOverlay.show(
      context,
      title: 'Yakin ingin menghapus?',
      message: 'Tindakan ini tidak dapat dibatalkan',
      actions: [
        DialogAction(
          label: 'Batal',
          style: DialogActionStyle.neutral,
          onTap: () {},
        ),
        DialogAction(
          label: 'Hapus',
          style: DialogActionStyle.destructive,
          onTap: () {
            setState(() {
              notifications.clear();
              Toast.show(
                context,
                title: 'Notifikasi',
                message: 'Semua notifikasi telah dihapus',
                type: ToastType.success,
                showCloseButton: true,
              );
            });
          },
        ),
      ],
    );
  }

  void _dismissNotification(int index) {
    setState(() => notifications.removeAt(index));
  }

  void _onNotificationTap(int index) {
    // TODO: handle notification tap
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTokens.background,
      extendBodyBehindAppBar: true,
      appBar: NotificationTopBar(
        notifications: notifications,
        onClearAllNotifications: _clearAllNotifications,
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text(
                'Belum ada notifikasi',
                style: TextStyle(fontSize: 16, color: AppColors.neutral400),
              ),
            )
          : NotificationList(
              notifications: notifications,
              onDismissed: _dismissNotification,
              onTap: _onNotificationTap,
            ),
    );
  }
}
