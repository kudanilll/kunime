import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/app/router/nav_ext.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/core/themes/app_tokens.dart';
import 'package:kunime/core/widgets/card.dart';
import 'package:kunime/features/home/application/search_controller.dart';
import 'package:kunime/features/home/application/search_state.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _controller;
  late final ScrollController _scrollController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _scrollController = ScrollController();
    // _scrollController.addListener(_onScroll);

    // Autofocus
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // void _onScroll() {
  //   if (!_scrollController.hasClients) return;

  //   final position = _scrollController.position;
  //   if (position.pixels >= position.maxScrollExtent - 200) {
  //     ref.read(searchControllerProvider.notifier).loadMore();
  //   }
  // }

  void _clear() {
    _controller.clear();
    ref.read(searchControllerProvider.notifier).clear();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchControllerProvider);
    final hasText = searchState.rawQuery.isNotEmpty;

    if (_controller.text != searchState.rawQuery) {
      _controller.text = searchState.rawQuery;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }

    return Scaffold(
      backgroundColor: AppTokens.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
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
        title: Container(
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
                child: PhosphorIcon(
                  PhosphorIcons.arrowLeft,
                  size: 16,
                  color: AppTokens.onSecondary,
                ),
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
                        .read(searchControllerProvider.notifier)
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
                    ? PhosphorIcon(
                        PhosphorIcons.x,
                        size: 16,
                        color: AppTokens.onSecondary,
                      )
                    : PhosphorIcon(
                        PhosphorIcons.magnifyingGlass,
                        size: 16,
                        color: AppTokens.onSecondary.withValues(alpha: 0.6),
                      ),
              ),
            ],
          ),
        ),
      ),
      body: _buildBody(searchState),
    );
  }

  Widget _buildBody(SearchState state) {
    if (state.rawQuery.trim().isEmpty) {
      if (state.history.isEmpty) {
        return const Center(
          child: Text(
            'Riwayat Pencarian Kosong',
            style: TextStyle(fontSize: 16, color: AppColors.neutral400),
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              16,
              MediaQuery.of(context).padding.top + kToolbarHeight + 8,
              16,
              8,
            ),
            child: const Text(
              'Riwayat Pencarian',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTokens.onSecondary,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              itemCount: state.history.length,
              itemBuilder: (_, i) {
                final anime = state.history[i];
                return KCard(
                  imageUrl: anime.image,
                  title: anime.title,
                  genres: anime.genres,
                  status: anime.status,
                  rating: anime.rating == "" ? "N/A" : anime.rating,
                  trailing: KCardTrailing.close,
                  onTap: () {
                    context.pushAnimeDetail(anime.endpoint);
                  },
                  onTrailingTap: () {
                    ref
                        .read(searchControllerProvider.notifier)
                        .removeHistory(anime);
                  },
                );
              },
            ),
          ),
        ],
      );
    }

    if (state.status == SearchStatus.loading) {
      return _buildSkeletonList();
    }

    if (state.status == SearchStatus.empty ||
        state.status == SearchStatus.error) {
      return const Center(child: Text('Tidak ada hasil'));
    }

    if (state.status == SearchStatus.success) {
      return ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + kToolbarHeight,
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        itemCount: state.results.length,
        itemBuilder: (_, i) {
          final anime = state.results[i];
          return KCard(
            imageUrl: anime.image,
            title: anime.title,
            genres: anime.genres,
            status: anime.status,
            rating: anime.rating == "" ? "N/A" : anime.rating,
            trailing: KCardTrailing.none,
            onTap: () {
              ref.read(searchControllerProvider.notifier).addToHistory(anime);
              context.pushAnimeDetail(anime.endpoint);
            },
          );
        },
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildSkeletonList() {
    return ListView.builder(
      itemCount: 8,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + kToolbarHeight,
      ),
      itemBuilder: (_, __) => const KCardSkeleton(),
    );
  }
}
