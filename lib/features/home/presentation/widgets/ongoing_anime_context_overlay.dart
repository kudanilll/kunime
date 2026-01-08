import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';
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
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.black.withValues(alpha: 0.4)),
          ),
        ),

        // Anchored card
        CompositedTransformFollower(
          link: link,
          showWhenUnlinked: false,
          offset: Offset.zero,
          child: Material(
            color: Colors.transparent,
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            child: OngoingAnimeCard(
              layerLink: LayerLink(), // dummy
              imageUrl: item.image,
              title: item.title,
              episode: 'Episode ${item.episode}',
              updateDay: item.day,
              onPressed: null,
              onLongPress: null,
            ),
          ),
        ),
      ],
    );
  }
}
