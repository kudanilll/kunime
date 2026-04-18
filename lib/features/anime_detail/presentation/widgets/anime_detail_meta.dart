import 'package:flutter/material.dart';
import 'package:kunime/core/themes/app_colors.dart';

class AnimeDetailMeta extends StatelessWidget {
  final String releaseDate;
  final String studio;
  final List<String> producers;

  const AnimeDetailMeta({
    super.key,
    required this.releaseDate,
    required this.studio,
    required this.producers,
  });

  @override
  Widget build(BuildContext context) {
    if (studio.isEmpty && producers.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        if (releaseDate.isNotEmpty) ...[_buildItem('Rilis', releaseDate)],
        if (studio.isNotEmpty) ...[_buildItem('Studio', studio)],
        if (producers.isNotEmpty) ...[
          _buildItem('Produsen', producers.join(', ')),
        ],
      ],
    );
  }

  Widget _buildItem(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: const TextStyle(color: AppColors.neutral500, fontSize: 12),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: AppColors.neutral300, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
