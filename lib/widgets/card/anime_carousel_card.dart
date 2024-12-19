import 'package:flutter/material.dart';

class AnimeCarouselCardProps {
  final String imageUrl;
  final String updateDay;
  final String title;
  final String episode;

  const AnimeCarouselCardProps({
    required this.imageUrl,
    required this.updateDay,
    required this.title,
    required this.episode,
  });
}

class AnimeCarouselCard extends StatelessWidget {
  final AnimeCarouselCardProps props;

  const AnimeCarouselCard({
    super.key,
    required this.props,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  props.imageUrl,
                  height: 200,
                  width: 140,
                  fit: BoxFit.cover,
                ),
              ),
              if (props.updateDay != 'None' && props.updateDay != 'Random')
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
          Text(
            props.episode,
            style: const TextStyle(color: Colors.red, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
