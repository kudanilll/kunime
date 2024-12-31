import 'package:avatar_better/avatar_better.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:random_avatar/random_avatar.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    String getGreeting() {
      var hour = DateTime.now().hour;
      if (hour < 11) {
        return 'Selamat Pagi';
      } else if (hour < 15) {
        return 'Selamat Siang';
      } else if (hour < 19) {
        return 'Selamat Sore';
      } else {
        return 'Selamat Malam';
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
          onPressed: () {}, // TODO: update later
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getGreeting(),
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
              fontFamily: 'Creato Display',
            ),
          ),
          const Text(
            'Daniel',
            style: TextStyle(
              fontSize: 20,
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
