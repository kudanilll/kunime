import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/core/widgets/svg_icon.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';
import 'package:kunime/features/home/presentation/widgets/context_menu_action_button.dart';
import 'package:kunime/features/home/presentation/sections/ongoing/ongoing_anime_card.dart';
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
    final menu = ref.watch(contextMenuProvider);
    final side = menu.side;

    const double cardWidth = 140;
    const double menuWidth = 180;
    const double gap = 18;

    Offset offset;
    switch (side) {
      case ContextMenuSide.right:
        offset = const Offset(cardWidth + gap, 0);
        break;
      case ContextMenuSide.left:
        offset = const Offset(-(menuWidth + gap), 0);
        break;
      case ContextMenuSide.bottom:
        offset = const Offset(0, 185);
        break;
    }

    return Stack(
      children: [
        // Background blur + tap to dismiss
        GestureDetector(
          behavior: HitTestBehavior.opaque,
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
        IgnorePointer(
          ignoring: true,
          child: CompositedTransformFollower(
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
        ),

        // Action Button
        CompositedTransformFollower(
          link: link,
          showWhenUnlinked: false,
          offset: offset,
          child: Material(
            type: MaterialType.transparency,
            child: IntrinsicWidth(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: side == ContextMenuSide.left
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  ContextMenuActionButton(
                    index: 0,
                    icon: SvgIcon.bookmark(18, AppColors.purple400).widget,
                    label: 'Tambahkan ke Favorit',
                    onTap: () {
                      ref.read(contextMenuProvider.notifier).hide();
                    },
                  ),
                  // const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
