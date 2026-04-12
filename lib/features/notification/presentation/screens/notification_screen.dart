import 'package:flutter/material.dart';
import 'package:kunime/core/overlays/dialog_overlay.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/core/themes/app_tokens.dart';
import 'package:kunime/core/widgets/svg_icon.dart';
import 'package:kunime/core/widgets/toast.dart';

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
    if (notifications.isEmpty) {
      return;
    }
    DialogOverlay.show(
      context,
      title: 'Yakin ingin menghapus?',
      message: 'Tindakan ini tidak dapat dibatalkan',
      actions: [
        DialogAction(
          label: 'Batal',
          style: DialogActionStyle.neutral,
          onTap: () {}, // Dismiss
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTokens.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
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
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Hapus Semua Notifikasi',
            icon: SvgIcon.trash(20, AppColors.errorBadge).widget,
            onPressed: _clearAllNotifications,
          ),
        ],
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text(
                'Belum ada notifikasi',
                style: TextStyle(fontSize: 16, color: AppColors.neutral400),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + kToolbarHeight,
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Dismissible(
                  key: Key(notification['title'] ?? ''),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: AppColors.red500,
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
                  child: InkWell(
                    onTap: () {
                      // TODO: handle notification tap
                    },
                    onLongPress: () {
                      // HapticFeedback.lightImpact();
                      // Nothing to do
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.blue600,
                            child: SvgIcon.bellActive(
                              22,
                              AppColors.white,
                            ).widget,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notification['title'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  notification['subtitle'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.neutral300,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            notification['time'] ?? '',
                            style: const TextStyle(
                              color: AppColors.neutral400,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
