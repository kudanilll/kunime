import 'package:flutter/material.dart';
import 'package:kunime/core/themes/app_tokens.dart';
import 'package:kunime/core/widgets/svg_icon.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).searchViewTheme.backgroundColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextField(
          style: TextStyle(color: AppTokens.onSecondary),
          decoration: InputDecoration(
            hintText: 'Cari Anime',
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 8),
              child: IconButton(
                onPressed: () {},
                icon: SvgIcon.search(16, AppTokens.onSecondary),
              ),
              // child: Icon(Icons.search),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 14),
          ),
          onChanged: (value) {},
        ),
      ),
    );
  }
}
