import 'package:flutter/material.dart';
import 'package:kunime/features/home/models/genre/model.dart';

class GenreCard extends StatelessWidget {
  final GenreModel genre;
  final int index;

  const GenreCard({super.key, required this.genre, required this.index});

  static const _colors = [
    Color(0xFFE53935),
    Color(0xFF8E24AA),
    Color(0xFF3949AB),
    Color(0xFF00897B),
    Color(0xFFF4511E),
    Color(0xFF6D4C41),
    Color(0xFF546E7A),
    Color(0xFF7CB342),
  ];

  @override
  Widget build(BuildContext context) {
    final bgColor = _colors[index % _colors.length];
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      alignment: Alignment.bottomLeft,
      child: Text(
        genre.name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
