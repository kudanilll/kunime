import 'package:flutter/material.dart';
import 'package:kunime/app/router/nav_ext.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/core/widgets/svg_icon.dart';

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
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: IconButton(
            icon: Badge.count(
              count: 3,
              backgroundColor: AppColors.red600,
              textColor: AppColors.white,
              child: SvgIcon.bellActive(24, AppColors.white).widget,
            ),
            onPressed: () => context.pushNotification(),
          ),
        ),
      ],
    );
  }
}
