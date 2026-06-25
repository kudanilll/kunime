import 'package:flutter/material.dart';
import 'package:kunime/core/themes/app_tokens.dart';
import 'package:kunime/app/router/nav_ext.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
      child: GestureDetector(
        onTap: () => context.pushSearch(),
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: Theme.of(context).searchViewTheme.backgroundColor,
            borderRadius: BorderRadius.circular(96),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Row(
            children: [
              PhosphorIcon(
                PhosphorIcons.magnifyingGlass,
                size: 18,
                color: AppTokens.onSecondary,
              ),
              const SizedBox(width: 16),
              Text(
                'Cari Anime',
                style: TextStyle(
                  color: AppTokens.onSecondary.withValues(alpha: 0.6),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
