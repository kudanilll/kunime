import 'package:flutter/material.dart';
import 'package:kunime/features/home/models/genre/model.dart';
import 'genre_card.dart';

class GenreGrid extends StatelessWidget {
  final List<GenreModel> genres;

  const GenreGrid({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    if (genres.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 48),
        child: Center(
          child: Text(
            'Genre tidak tersedia',
            style: TextStyle(color: Colors.white54),
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: genres.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.6,
      ),
      itemBuilder: (context, index) {
        return GenreCard(genre: genres[index], index: index);
      },
    );
  }
}
