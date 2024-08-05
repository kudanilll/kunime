import 'package:flutter/material.dart';

class AnimeCardProps {
  final String imageUrl;
  final String updateDay;
  final String title;
  final String episode;

  const AnimeCardProps({
    required this.imageUrl,
    required this.updateDay,
    required this.title,
    required this.episode,
  });
}

class AnimeCard extends StatelessWidget {
  final AnimeCardProps props;

  const AnimeCard({
    super.key,
    required this.props,
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
                  props.imageUrl,
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
                  child: Text(
                    props.updateDay,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            props.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(props.episode,
              style: const TextStyle(color: Colors.red, fontSize: 12)),
        ],
      ),
    );
  }
}
