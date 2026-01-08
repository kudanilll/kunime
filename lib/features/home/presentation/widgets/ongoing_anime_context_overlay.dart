import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';
import 'package:kunime/features/home/presentation/widgets/context_menu_action_button.dart';
import 'package:kunime/features/home/presentation/widgets/ongoing_anime_card.dart';
import 'package:kunime/features/home/providers/context_menu_provider.dart';

class OngoingAnimeContextOverlay extends ConsumerWidget {
  final UiOngoing item;
  final LayerLink link;

  const OngoingAnimeContextOverlay({
    super.key,
    required this.item,
    required this.link,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        // Background blur + tap to dismiss
        GestureDetector(
          onTap: () {
            ref.read(contextMenuProvider.notifier).hide();
          },
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            builder: (context, t, _) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12 * t, sigmaY: 12 * t),
                child: Container(
                  color: Colors.black.withValues(alpha: 0.45 * t),
                ),
              );
            },
          ),
        ),

        // Animated anchored card
        CompositedTransformFollower(
          link: link,
          showWhenUnlinked: false,
          offset: Offset.zero,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.94, end: 1.1),
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutBack,
            builder: (context, scale, child) {
              return Transform.scale(scale: scale, child: child);
            },
            child: Material(
              color: Colors.transparent,
              elevation: 12,
              borderRadius: BorderRadius.circular(12),
              child: OngoingAnimeCard(
                layerLink: LayerLink(),
                imageUrl: item.image,
                title: item.title,
                episode: 'Episode ${item.episode}',
                updateDay: item.day,
                onPressed: null,
                onLongPress: null,
              ),
            ),
          ),
        ),

        // Action Button
        CompositedTransformFollower(
          link: link,
          showWhenUnlinked: false,
          offset: const Offset(0, 210),
          child: Material(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ContextMenuActionButton(
                  index: 0,
                  icon: Icons.favorite_border,
                  label: 'Tambahkan ke Favorit',
                  onTap: () {
                    ref.read(contextMenuProvider.notifier).hide();
                    // TODO: favorit logic
                  },
                ),
                const SizedBox(height: 8),
                ContextMenuActionButton(
                  index: 2,
                  icon: Icons.share,
                  label: 'Bagikan',
                  onTap: () {
                    ref.read(contextMenuProvider.notifier).hide();
                    // TODO: share logic
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
