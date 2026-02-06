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
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Row(
                children: [
                  // Back button
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                  ),

                  // Search input
                  Expanded(
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).searchViewTheme.backgroundColor,
                        borderRadius: BorderRadius.circular(96),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        children: [
                          SvgIcon.search(18, AppTokens.onSecondary).widget,
                          const SizedBox(width: 16),
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
                                  color: AppTokens.onSecondary.withValues(
                                    alpha: 0.6,
                                  ),
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
                              onSubmitted: (value) {
                                // TODO: trigger search
                              },
                            ),
                          ),
                          if (hasText)
                            GestureDetector(
                              onTap: _clear,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: SvgIcon.close(
                                  16,
                                  AppTokens.onSecondary,
                                ).widget,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
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
