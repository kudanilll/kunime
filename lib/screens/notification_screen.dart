import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final List<Map<String, String>> notifications = [
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        centerTitle: true,
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
                return ListTile(
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
                );
              },
            ),
    );
  }
}
