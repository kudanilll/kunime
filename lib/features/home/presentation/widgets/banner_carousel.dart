import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';

class BannerCarousel extends StatelessWidget {
  final List<UiBanner> items;
  final void Function(UiBanner banner)? onTapBanner;
  final double height;
  final double viewportFraction;
  final bool autoplay;
  final BorderRadiusGeometry borderRadius;

  const BannerCarousel({
    super.key,
    required this.items,
    this.onTapBanner,
    this.height = 200,
    this.viewportFraction = 0.86,
    this.autoplay = true,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: height,
      child: Swiper(
        itemCount: items.length,
        autoplay: autoplay,
        viewportFraction: viewportFraction,
        scale: 0.92,
        itemBuilder: (context, index) {
          final b = items[index];
          return ClipRRect(
            borderRadius: borderRadius,
            child: InkWell(
              onTap: onTapBanner == null ? null : () => onTapBanner!(b),
              child: _BannerImage(
                url: b.imageUrl,
                label: 'Banner ${index + 1}',
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BannerImage extends StatelessWidget {
  final String url;
  final String? label;
  const _BannerImage({required this.url, this.label});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      semanticLabel: label,
      loadingBuilder: (ctx, child, progress) {
        if (progress == null) return child;
        return DecoratedBox(
          decoration: const BoxDecoration(color: Color(0x11000000)),
          child: const Center(child: CircularProgressIndicator()),
        );
      },
      errorBuilder: (_, __, ___) => Container(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        alignment: Alignment.center,
        child: const Icon(Icons.broken_image_outlined),
      ),
    );
  }
}
