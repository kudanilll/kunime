import 'package:flutter/material.dart';
import 'package:kunime/core/themes/app_colors.dart';

class AnimeDetailDescription extends StatefulWidget {
  final String synopsis;

  const AnimeDetailDescription({
    super.key,
    required this.synopsis,
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
          const SizedBox(height: 16),
          const Text(
            'Sinopsis',
            style: TextStyle(
              color: AppColors.neutral300,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            displayText,
            style: const TextStyle(
              color: AppColors.neutral400,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          if (shouldShowButton)
            GestureDetector(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  _isExpanded ? 'Tampilkan lebih sedikit' : 'Lihat selengkapnya',
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