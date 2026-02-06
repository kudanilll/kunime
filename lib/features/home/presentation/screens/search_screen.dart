import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/core/themes/app_tokens.dart';
import 'package:kunime/core/widgets/card.dart';
import 'package:kunime/core/widgets/svg_icon.dart';
import 'package:kunime/features/home/providers/search_provider.dart';
import 'package:kunime/features/home/providers/search_state.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

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
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    ref.read(searchProvider.notifier).clear();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchProvider);
    final hasText = searchState.rawQuery.isNotEmpty;

    if (_controller.text != searchState.rawQuery) {
      _controller.text = searchState.rawQuery;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }

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
                          ref
                              .read(searchProvider.notifier)
                              .onQueryChanged(value);
                        },
                        onSubmitted: (_) {},
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
            Expanded(child: _buildBody(searchState)),
          ],
        ),
      ),
    );
  }

  // TESTING: Build body based on search state
  Widget _buildBody(SearchState state) {
    switch (state.status) {
      case SearchStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case SearchStatus.empty:
        return const Center(child: Text('Tidak ada hasil'));
      case SearchStatus.error:
        return Center(child: Text(state.error ?? 'Error'));
      case SearchStatus.success:
        return ListView.builder(
          itemCount: state.results.length,
          itemBuilder: (_, i) {
            final anime = state.results[i];

            return KCard(
              imageUrl: anime.image,
              title: anime.title,
              season: anime.status,
              rating: anime.rating,
              trailing: KCardTrailing.none,
              onTap: () {
                // TODO: navigate ke anime detail
                // context.pushAnimeDetail(anime.endpoint);
              },
            );
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
