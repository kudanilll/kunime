import 'package:flutter/material.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/core/widgets/svg_icon.dart';

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
  ];

  void _clearAllNotifications() {
    setState(() {
      notifications.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          notifications.isEmpty
              ? 'Notifikasi'
              : 'Notifikasi (${notifications.length})',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _clearAllNotifications,
            child: const Text(
              'Hapus semua',
              style: TextStyle(fontSize: 14, color: AppColors.red600),
            ),
          ),
        ],
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text(
                'Belum ada notifikasi.',
                style: TextStyle(fontSize: 16, color: AppColors.neutral400),
              ),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Dismissible(
                  key: Key(notification['title'] ?? ''),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20.0),
                    child: const Icon(Icons.delete, color: AppColors.white),
                  ),
                  onDismissed: (direction) {
                    // Hapus item dari list
                    setState(() {
                      notifications.removeAt(index);
                    });
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.blue600,
                      child: SvgIcon.bellActive(22, AppColors.white).widget,
                    ),
                    title: Text(
                      notification['title'] ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      notification['subtitle'] ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.neutral200,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(
                      notification['time'] ?? '',
                      style: const TextStyle(
                        color: AppColors.neutral400,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    onTap: () {
                      // TODO: handle notification tap
                    },
                    onLongPress: () {
                      // TODO: handle notification long press
                    },
                  ),
                );
              },
            ),
    );
  }
}
