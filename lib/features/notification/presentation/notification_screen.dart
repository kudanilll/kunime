import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _clearAllNotifications,
            child: const Text(
              'Hapus semua',
              style: TextStyle(fontSize: 15, color: Colors.blue),
            ),
          ),
        ],
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text(
                'Tidak ada notifikasi.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
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
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    // Hapus item dari list
                    setState(() {
                      notifications.removeAt(index);
                    });
                  },
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Icon(
                        FontAwesomeIcons.solidBell,
                        size: 22,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(notification['title'] ?? ''),
                    subtitle: Text(notification['subtitle'] ?? ''),
                    trailing: Text(
                      notification['time'] ?? '',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
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
