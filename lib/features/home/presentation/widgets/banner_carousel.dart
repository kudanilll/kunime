import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/features/home/presentation/widgets/banner_skeleton.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';
import 'package:card_swiper/card_swiper.dart';

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
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: SizedBox(
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
                splashColor: Colors.transparent,
                onTap: onTapBanner == null ? null : () => onTapBanner!(b),
                child: CachedNetworkImage(
                  imageUrl: b.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => const BannerSkeleton(),
                  errorWidget: (_, __, ___) => Container(
                    color: AppColors.neutral400,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.broken_image_outlined,
                      color: AppColors.error,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
