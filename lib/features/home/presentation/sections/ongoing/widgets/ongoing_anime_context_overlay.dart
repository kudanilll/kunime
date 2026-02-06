import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/core/overlays/context_menu_overlay.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/core/widgets/svg_icon.dart';
import 'package:kunime/features/home/models/context_menu_action.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';
import 'package:kunime/features/home/presentation/sections/ongoing/widgets/ongoing_anime_card.dart';
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

    final Offset offset = switch (side) {
      ContextMenuSide.right => const Offset(cardWidth + gap, 0),
      ContextMenuSide.left => const Offset(-(menuWidth + gap), 0),
      ContextMenuSide.bottom => const Offset(0, 185),
    };

    final actions = [
      ContextMenuAction(
        icon: SvgIcon.bookmark(18, AppColors.purple400).widget,
        label: 'Tambahkan ke Favorit',
        onTap: () {
          ref.read(contextMenuProvider.notifier).hide();
        },
      ),
    ];

    final preview = TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.94, end: 1.050),
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
    );

    return ContextMenuOverlay(
      link: link,
      offset: offset,
      preview: preview,
      actions: actions,
    );
  }
}
