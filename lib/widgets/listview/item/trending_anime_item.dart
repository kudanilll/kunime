import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TrendingAnimeItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int episode;
  final VoidCallback? onPressed;

  const TrendingAnimeItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.episode,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.white.withAlpha(30),
        highlightColor: Colors.white.withAlpha(100),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Episode $episode',
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(12),
                child: FaIcon(FontAwesomeIcons.play, size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
