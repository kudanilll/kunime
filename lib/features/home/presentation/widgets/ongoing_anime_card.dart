import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kunime/features/home/presentation/widgets/ongoing_anime_skeleton_card.dart';

class OngoingAnimeCard extends StatelessWidget {
  final LayerLink layerLink;
  final String imageUrl;
  final String updateDay;
  final String title;
  final String episode;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;

  const OngoingAnimeCard({
    super.key,
    required this.layerLink,
    required this.imageUrl,
    required this.updateDay,
    required this.title,
    required this.episode,
    this.onPressed,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: SizedBox(
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      // Skeleton/placeholder
                      Container(
                        height: 200,
                        width: 140,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(
                            Icons.movie_creation,
                            color: Colors.grey,
                            size: 40,
                          ),
                        ),
                      ),

                      // Actual image
                      CachedNetworkImage(
                        imageUrl: imageUrl,
                        height: 200,
                        width: 140,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          height: 200,
                          width: 140,
                          color: Colors.grey[300],
                          child: OngoingAnimeSkeletonCard(),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 200,
                          width: 140,
                          color: Colors.grey[300],
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error, size: 30, color: Colors.red),
                              SizedBox(height: 4),
                              Text(
                                'Error',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Gradient
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.9),
                                Colors.black.withValues(alpha: 0.7),
                                Colors.black.withValues(alpha: 0.4),
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.3, 0.6, 1.0],
                            ),
                          ),
                        ),
                      ),

                      // Click effect
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: onPressed,
                            onLongPress: onLongPress,
                            borderRadius: BorderRadius.circular(10),
                            splashColor: Colors.white.withAlpha(50),
                            highlightColor: Colors.white.withAlpha(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Text title & episode inside image
                Positioned(
                  bottom: 12,
                  left: 8,
                  right: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          shadows: [
                            Shadow(
                              blurRadius: 4,
                              color: Colors.black87,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        episode,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          shadows: [
                            Shadow(
                              blurRadius: 4,
                              color: Colors.black87,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Update day badge
                if (updateDay != 'None' && updateDay != 'Random')
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        updateDay,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
