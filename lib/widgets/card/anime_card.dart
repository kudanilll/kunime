import 'package:flutter/material.dart';

class AnimeCard extends StatelessWidget {
  final String imageUrl;
  final int viewCount;
  final String title;
  final int episode;
  final int daysAgo;

  const AnimeCard({
    super.key,
    required this.imageUrl,
    required this.viewCount,
    required this.title,
    required this.episode,
    required this.daysAgo,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140, // Sesuaikan lebar card
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  height:
                      200, // Tinggi gambar lebih besar untuk orientasi vertikal
                  width: 140,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.visibility,
                          color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '$viewCount',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text('Eps $episode',
              style: const TextStyle(color: Colors.red, fontSize: 12)),
        ],
      ),
    );
  }
}
