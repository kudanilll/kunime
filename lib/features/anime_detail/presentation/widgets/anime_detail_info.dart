import 'package:flutter/material.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/core/widgets/button.dart';
import 'package:kunime/core/widgets/chip.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

class AnimeDetailInfo extends StatelessWidget {
  final String score;
  final String type;
  final String status;
  final List<String> genres;

  const AnimeDetailInfo({
    super.key,
    required this.score,
    required this.type,
    required this.status,
    required this.genres,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildInfoRow(),
          const SizedBox(height: 16),
          _buildGenresRow(),
          const SizedBox(height: 16),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildInfoRow() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _InfoItem(value: type),
        const Text('●', style: TextStyle(color: AppColors.neutral500)),
        _InfoItem(value: status),
        if (score.isNotEmpty) ...[
          const Text('●', style: TextStyle(color: AppColors.neutral500)),
          _InfoItem(value: score, icon: Icons.star_rounded),
        ],
      ],
    );
  }

  Widget _buildGenresRow() {
    return Wrap(
      spacing: 8,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      direction: Axis.horizontal,
      children: genres.map((genre) => KChip(label: genre)).toList(),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 12,
      children: [
        KButton(
          label: 'Putar',
          icon: PhosphorIcons.play,
          variant: KButtonVariant.primary,
          onPressed: () {},
        ),
        KButton(
          label: 'Simpan',
          icon: PhosphorIcons.bookmark,
          variant: KButtonVariant.secondary,
          onPressed: () {},
        ),
      ],
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String value;
  final IconData? icon;

  const _InfoItem({required this.value, this.icon});

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
      ],
    );
  }
}
