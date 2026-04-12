import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';
import 'package:kunime/features/home/presentation/widgets/banner_skeleton.dart';

class BannerCarousel extends StatefulWidget {
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
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final Set<String> _failedImageUrls = <String>{};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _precacheBanners();
  }

  @override
  void didUpdateWidget(covariant BannerCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items == widget.items) return;

    final currentUrls = widget.items
        .map((banner) => banner.imageUrl.trim())
        .where((url) => url.isNotEmpty)
        .toSet();

    _failedImageUrls.removeWhere((url) => !currentUrls.contains(url));
    _precacheBanners();
  }

  void _precacheBanners() {
    for (final banner in widget.items) {
      final imageUrl = banner.imageUrl.trim();
      if (imageUrl.isEmpty || _failedImageUrls.contains(imageUrl)) continue;

      precacheImage(CachedNetworkImageProvider(imageUrl), context).catchError((
        _,
      ) {
        if (!mounted) return;
        setState(() => _failedImageUrls.add(imageUrl));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: SizedBox(
        height: widget.height,
        child: Swiper(
          itemCount: widget.items.length,
          autoplay: widget.autoplay,
          viewportFraction: widget.viewportFraction,
          scale: 0.92,
          itemBuilder: (context, index) {
            final b = widget.items[index];
            final imageUrl = b.imageUrl.trim();
            return ClipRRect(
              borderRadius: widget.borderRadius,
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: widget.onTapBanner == null
                    ? null
                    : () => widget.onTapBanner!(b),
                child: _failedImageUrls.contains(imageUrl) || imageUrl.isEmpty
                    ? const _BannerImageError()
                    : CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => const BannerSkeleton(),
                        errorWidget: (_, failedUrl, ___) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (!mounted) return;
                            setState(() => _failedImageUrls.add(failedUrl));
                          });
                          return const _BannerImageError();
                        },
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _BannerImageError extends StatelessWidget {
  const _BannerImageError();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.neutral400,
      alignment: Alignment.center,
      child: const Icon(Icons.broken_image_outlined, color: AppColors.error),
    );
  }
}
