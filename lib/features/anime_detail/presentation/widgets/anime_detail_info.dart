import 'package:flutter/material.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/core/themes/app_tokens.dart';

class AnimeDetailInfo extends StatelessWidget {
  final String score;
  final String type;
  final String status;
  final String totalEpisode;
  final String duration;
  final String releaseDate;

  const AnimeDetailInfo({
    super.key,
    required this.score,
    required this.type,
    required this.status,
    required this.totalEpisode,
    required this.duration,
    required this.releaseDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildInfoRow(),
          const SizedBox(height: 16),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildInfoRow() {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: [
        _InfoItem(label: 'Skor', value: score, icon: Icons.star_rounded),
        _InfoItem(label: 'Tipe', value: type),
        _InfoItem(label: 'Status', value: status),
        _InfoItem(label: 'Eps', value: totalEpisode),
        _InfoItem(label: 'Durasi', value: duration),
        _InfoItem(label: 'Tayang', value: releaseDate),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.purple500,
                borderRadius: BorderRadius.circular(96),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_arrow_rounded,
                    color: AppColors.neutral100,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Putar',
                    style: TextStyle(
                      color: AppColors.neutral100,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTokens.secondary,
              borderRadius: BorderRadius.circular(96),
            ),
            child: const Icon(
              Icons.bookmark_border_rounded,
              color: AppColors.neutral200,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;

  const _InfoItem({
    required this.label,
    required this.value,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 16, color: AppColors.yellow500),
          const SizedBox(width: 4),
        ],
        Text(
          value,
          style: const TextStyle(
            color: AppColors.neutral200,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.neutral500,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}