import 'package:flutter/material.dart';
import 'package:kunime/app/router/nav_ext.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/core/themes/app_tokens.dart';
import 'package:kunime/core/widgets/svg_icon.dart';

class HomeTopBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
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
      title: const Text(
        'Kunime',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
      titleSpacing: 0,
      leading: SvgIcon.logo(24, AppColors.white).iconButton,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: IconButton(
            tooltip: 'Notifikasi',
            icon: Badge.count(
              count: 3,
              backgroundColor: AppColors.blue500,
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
