import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/features/home/models/genre/ui_genre.dart';

class GenreCard extends StatelessWidget {
  final UiGenre genre;

  const GenreCard({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(color: Colors.transparent, child: _buildBackgroundInk()),
    );
  }

  Widget _buildBackgroundInk() {
    if (genre.imageUrl == null || genre.imageUrl!.isEmpty) {
      return Ink(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.neutral700, AppColors.neutral900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: InkWell(
          splashColor: AppColors.white.withValues(alpha: 0.15),
          highlightColor: AppColors.white.withValues(alpha: 0.08),
          onTap: () {},
          child: Stack(
            fit: StackFit.expand,
            children: [_buildOverlay(), _buildTitle()],
          ),
        ),
      );
    }

    return Ink.image(
      image: CachedNetworkImageProvider(genre.imageUrl!),
      fit: BoxFit.cover,
      child: InkWell(
        splashColor: AppColors.white.withValues(alpha: 0.15),
        highlightColor: AppColors.white.withValues(alpha: 0.08),
        onTap: () {},
        child: Stack(
          fit: StackFit.expand,
          children: [_buildOverlay(), _buildTitle()],
        ),
      ),
    );
  }

  Widget _buildOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withValues(alpha: 0.5),
            Colors.black.withValues(alpha: 0.7),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          genre.name,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.onBackground,
          ),
        ),
      ),
    );
  }
}
