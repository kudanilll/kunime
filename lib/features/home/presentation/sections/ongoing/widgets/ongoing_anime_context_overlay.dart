import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/core/overlays/context_menu_overlay.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/features/home/application/context_menu_controller.dart';
import 'package:kunime/features/home/application/context_menu_state.dart';
import 'package:kunime/features/home/models/context_menu_action.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';
import 'package:kunime/features/home/presentation/sections/ongoing/widgets/ongoing_anime_card.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

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
    final menu = ref.watch(homeContextMenuProvider);
    final side = menu.side;

    const double cardWidth = 140;
    const double menuWidth = 180;
    const double gap = 12;

    final Offset offset = switch (side) {
      ContextMenuSide.right => const Offset(cardWidth + gap, 0),
      ContextMenuSide.left => const Offset(
        -(menuWidth - cardWidth + (gap + 6)) * 2,
        0,
      ),
      ContextMenuSide.bottom => const Offset(0, 210),
    };

    final actions = [
      ContextMenuAction(
        icon: PhosphorIcon(
          PhosphorIcons.bookmark,
          size: 18,
          color: AppColors.purple100,
        ),
        label: 'Simpan',
        onTap: () {
          ref.read(homeContextMenuProvider.notifier).hide();
        },
      ),
    ];

    final preview = Material(
      color: Colors.transparent,
      elevation: 12,
      borderRadius: BorderRadius.circular(12),
      child: OngoingAnimeCard(
        layerLink: LayerLink(),
        imageUrl: item.image,
        title: item.title,
        episode: 'Episode ${item.episode}',
        isNewRelease: item.isNewRelease,
        updateDay: item.day,
        onPressed: null,
        onLongPress: null,
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
