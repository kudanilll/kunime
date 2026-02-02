import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/core/widgets/text_button.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';
import 'package:kunime/features/home/presentation/widgets/ongoing_anime_card.dart';
import 'package:kunime/features/home/presentation/widgets/ongoing_anime_skeleton_list.dart';
import 'package:kunime/features/home/providers/context_menu_provider.dart';

class OngoingAnimeCarousel extends ConsumerStatefulWidget {
  final AsyncValue<List<UiOngoing>> value;
  final void Function(UiOngoing) onTapItem;
  final VoidCallback? onSeeAll;

  final String title;
  final double height;
  final int limit;

  const OngoingAnimeCarousel({
    super.key,
    required this.value,
    required this.onTapItem,
    this.onSeeAll,
    this.title = 'Sedang Berlangsung',
    this.height = 200,
    this.limit = 8,
  });

  @override
  ConsumerState<OngoingAnimeCarousel> createState() =>
      _OngoingAnimeCarouselState();
}

class _OngoingAnimeCarouselState extends ConsumerState<OngoingAnimeCarousel> {
  final Map<String, LayerLink> _links = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              KTextButton(
                label: 'Lihat Semua',
                onTap: () => widget.onSeeAll?.call(),
              ),
            ],
          ),
        ),

        widget.value.when(
          loading: () => const OngoingAnimeSkeletonList(),
          error: (_, __) => const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Gagal memuat data'),
          ),
          data: (items) {
            final data = items.take(widget.limit).toList();
            if (data.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    'Tidak ada data',
                    style: TextStyle(color: AppColors.neutral400),
                  ),
                ),
              );
            }

            return SizedBox(
              height: widget.height,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: data.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final anime = data[index];
                  // final layerLink = LayerLink();
                  final layerLink = _links.putIfAbsent(
                    anime.title,
                    () => LayerLink(),
                  );
                  return Builder(
                    builder: (cardContext) {
                      return OngoingAnimeCard(
                        layerLink: layerLink,
                        imageUrl: anime.image,
                        title: anime.title,
                        episode: 'Episode ${anime.episode}',
                        updateDay: anime.day,
                        onPressed: () => widget.onTapItem(anime),
                        onLongPress: () {
                          final renderObject = cardContext.findRenderObject();
                          if (renderObject is! RenderBox) return;
                          final offset = renderObject.localToGlobal(
                            Offset.zero,
                          );
                          final rect = offset & renderObject.size;
                          HapticFeedback.lightImpact();
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ref
                                .read(contextMenuProvider.notifier)
                                .show(anime, layerLink, rect, context);
                          });
                        },
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
