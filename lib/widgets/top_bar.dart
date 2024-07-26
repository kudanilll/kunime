import 'package:flutter/material.dart';
import 'package:avatar_better/avatar_better.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:random_avatar/random_avatar.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    // Fungsi untuk mendapatkan salam berdasarkan waktu
    String getGreeting() {
      var hour = DateTime.now().hour;
      if (hour < 12) {
        return 'Good Morning';
      } else if (hour < 17) {
        return 'Good Afternoon';
      } else {
        return 'Good Evening';
      }
    }

    const userHaveAvatar = false;
    Widget userAvatar;
    if (userHaveAvatar == true) {
      userAvatar = Avatar(
          text: 'M', radius: 35, randomGradient: true, randomColor: false);
    } else {
      userAvatar = RandomAvatar('saytoonz', height: 50, width: 50);
    }

    return AppBar(
      elevation: 0,
      leadingWidth: 70,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: IconButton(
          icon: userAvatar,
          onPressed: () {},
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getGreeting(),
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const Text(
            'Daniel',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: IconButton(
            icon: const FaIcon(FontAwesomeIcons.solidBell),
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
