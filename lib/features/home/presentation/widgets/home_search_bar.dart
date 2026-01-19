import 'package:flutter/material.dart';
import 'package:kunime/core/themes/app_tokens.dart';
import 'package:kunime/core/widgets/svg_icon.dart';

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({super.key});

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  late final TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    _controller.addListener(() {
      final hasTextNow = _controller.text.isNotEmpty;
      if (hasTextNow != _hasText) {
        setState(() => _hasText = hasTextNow);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).searchViewTheme.backgroundColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextField(
          controller: _controller,
          style: const TextStyle(color: AppTokens.onSecondary),
          decoration: InputDecoration(
            hintText: 'Cari Anime',
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: SvgIcon.search(18, AppTokens.onSecondary).iconButton,
            ),
            suffixIcon: _hasText
                ? GestureDetector(
                    onTap: _clear,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: SvgIcon.close(
                        16,
                        AppTokens.onSecondary,
                      ).iconButton,
                    ),
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onChanged: (value) {
            // TODO: handle search
          },
        ),
      ),
    );
  }
}
