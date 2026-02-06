import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kunime/core/themes/app_tokens.dart';
import 'package:kunime/core/widgets/svg_icon.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  Timer? _debounce;
  String _debouncedQuery = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();

    // Autofocus
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final hasText = _controller.text.isNotEmpty;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top Search Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: Theme.of(context).searchViewTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(96),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // Left icon: back
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: SvgIcon.arrowLeft(
                        16,
                        AppTokens.onSecondary,
                      ).widget,
                    ),

                    const SizedBox(width: 18),

                    // Input
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        autofocus: true,
                        style: const TextStyle(
                          color: AppTokens.onSecondary,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Cari Anime',
                          hintStyle: TextStyle(
                            color: AppTokens.onSecondary.withValues(alpha: 0.6),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        textInputAction: TextInputAction.search,
                        onChanged: (value) {
                          setState(() {});
                          _onQueryChanged(value);
                        },
                        onSubmitted: (_) {
                          // nanti trigger search final
                        },
                      ),
                    ),

                    const SizedBox(width: 14),

                    // Right icon: search / clear
                    GestureDetector(
                      onTap: hasText ? _clear : null,
                      child: hasText
                          ? SvgIcon.close(16, AppTokens.onSecondary).widget
                          : SvgIcon.search(
                              16,
                              AppTokens.onSecondary.withValues(alpha: 0.6),
                            ).widget,
                    ),
                  ],
                ),
              ),
            ),

            // Body
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  String _normalizeQuery(String input) {
    return input.trim().toLowerCase().replaceAll(RegExp(r'\s+'), '+');
  }

  void _onQueryChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 550), () {
      final normalized = _normalizeQuery(value);

      setState(() {
        _debouncedQuery = normalized;
      });

      // TODO: trigger API search using normalized query
    });
  }

  // Test: show debounced query
  Widget _buildBody() {
    if (_controller.text.isEmpty) {
      return const Center(
        child: Text(
          'Cari anime favoritmu',
          style: TextStyle(color: AppTokens.onSecondary, fontSize: 14),
        ),
      );
    }

    if (_debouncedQuery.isEmpty) {
      return const Center(
        child: Text(
          'Menunggu input...',
          style: TextStyle(color: AppTokens.onSecondary, fontSize: 14),
        ),
      );
    }

    return Center(
      child: Text(
        'Query debounce: "$_debouncedQuery"',
        style: const TextStyle(color: AppTokens.onSecondary, fontSize: 14),
      ),
    );
  }
}
