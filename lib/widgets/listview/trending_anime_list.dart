import 'package:flutter/material.dart';
import 'package:kunime/widgets/listview/item/trending_anime_item.dart';

final List<Map<String, dynamic>> trendingAnimes = [
  {
    "imageUrl": "https://cdn.myanimelist.net/images/anime/1000/110531.jpg",
    "title": "Attack on Titan",
    "episode": 75,
  },
  {
    "imageUrl": "https://cdn.myanimelist.net/images/anime/1286/99889.jpg",
    "title": "Demon Slayer",
    "episode": 26,
  },
  {
    "imageUrl": "https://cdn.myanimelist.net/images/anime/1911/113611.jpg",
    "title": "My Hero Academia",
    "episode": 113,
  },
  {
    "imageUrl": "https://cdn.myanimelist.net/images/anime/1244/138851.jpg",
    "title": "One Piece",
    "episode": 1000,
  },
  {
    "imageUrl": "https://cdn.myanimelist.net/images/anime/1565/111305.jpg",
    "title": "Naruto Shippuden",
    "episode": 24,
  },
];

class TrendingAnimeList extends StatelessWidget {
  const TrendingAnimeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Text(
            'Trending Minggu Ini',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: trendingAnimes.length,
          itemBuilder: (context, index) {
            final anime = trendingAnimes[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TrendingAnimeItem(
                imageUrl: anime['imageUrl'],
                title: anime['title'],
                episode: anime['episode'],
              ),
            );
          },
        ),
      ],
    );
  }
}
