import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:kunime/widgets/card/anime_card.dart';

final List<Map<String, dynamic>> animeList = [
  {
    "imageUrl": "https://cdn.myanimelist.net/images/anime/1565/111305.jpg",
    "viewCount": 10000,
    "title": "Naruto Shippuden",
    "episode": 500,
    "daysAgo": 2,
  },
  {
    "imageUrl": "https://cdn.myanimelist.net/images/anime/1244/138851.jpg",
    "viewCount": 8000,
    "title": "One Piece",
    "episode": 1000,
    "daysAgo": 1,
  },
  {
    "imageUrl": "https://cdn.myanimelist.net/images/anime/1000/110531.jpg",
    "viewCount": 12000,
    "title": "Attack on Titan",
    "episode": 75,
    "daysAgo": 3,
  },
  {
    "imageUrl": "https://cdn.myanimelist.net/images/anime/1911/113611.jpg",
    "viewCount": 9000,
    "title": "My Hero Academia",
    "episode": 113,
    "daysAgo": 5,
  },
  {
    "imageUrl": "https://cdn.myanimelist.net/images/anime/1286/99889.jpg",
    "viewCount": 7500,
    "title": "Demon Slayer",
    "episode": 26,
    "daysAgo": 4,
  },
];

class MostSearchedAnimeCarousel extends StatelessWidget {
  const MostSearchedAnimeCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Paling Banyak Dicari',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 280,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              final anime = animeList[index];
              return AnimeCard(
                imageUrl: anime["imageUrl"],
                viewCount: anime["viewCount"],
                title: anime["title"],
                episode: anime["episode"],
                daysAgo: anime["daysAgo"],
              );
            },
            itemCount: animeList.length,
            viewportFraction: 0.4,
          ),
        ),
      ],
    );
  }
}
