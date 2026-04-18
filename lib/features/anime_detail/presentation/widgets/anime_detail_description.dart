import 'package:flutter/material.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/features/anime_detail/presentation/widgets/anime_detail_meta.dart';

class AnimeDetailDescription extends StatefulWidget {
  final String synopsis;
  final String releaseDate;
  final String studio;
  final List<String> producers;

  const AnimeDetailDescription({
    super.key,
    required this.releaseDate,
    required this.synopsis,
    required this.studio,
    required this.producers,
  });

  @override
  State<AnimeDetailDescription> createState() => _AnimeDetailDescriptionState();
}

class _AnimeDetailDescriptionState extends State<AnimeDetailDescription> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    if (widget.synopsis.isEmpty) return const SizedBox.shrink();

    final shouldShowButton = widget.synopsis.length > 200;
    final displayText = shouldShowButton && !_isExpanded
        ? '${widget.synopsis.substring(0, 200)}...'
        : widget.synopsis;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            displayText,
            style: const TextStyle(
              color: AppColors.neutral400,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          if (_isExpanded || !shouldShowButton)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: AnimeDetailMeta(
                releaseDate: widget.releaseDate,
                studio: widget.studio,
                producers: widget.producers,
              ),
            ),
          if (shouldShowButton)
            GestureDetector(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  _isExpanded
                      ? 'Tampilkan lebih sedikit'
                      : 'Lihat selengkapnya',
                  style: const TextStyle(
                    color: AppColors.purple300,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
