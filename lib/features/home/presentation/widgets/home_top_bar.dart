import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kunime/app/router/nav_ext.dart';

class HomeTopBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      elevation: 0,
      title: const Text(
        'Kunime',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: IconButton(
            icon: Badge.count(
              count: 3,
              child: const FaIcon(FontAwesomeIcons.solidBell),
            ),
            onPressed: () => AppNav(context).pushNotification(),
          ),
        ),
      ],
    );
  }
}
