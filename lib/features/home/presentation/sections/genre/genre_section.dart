import 'package:flutter/material.dart';
import 'package:kunime/core/themes/app_colors.dart';

class GenreSection extends StatelessWidget {
  const GenreSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Text(
        'Genre section (coming soon)',
        style: TextStyle(color: AppColors.neutral400),
      ),
    );
  }
}
