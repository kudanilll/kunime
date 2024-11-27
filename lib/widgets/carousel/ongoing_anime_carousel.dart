import 'package:flutter/material.dart';
import 'package:kunime/services/api/models/ongoing/model.dart';
import 'package:kunime/services/api/services/api_service.dart';
import 'package:kunime/widgets/card/anime_carousel_card.dart';

class OngoingAnimeCarousel extends StatelessWidget {
  const OngoingAnimeCarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Text(
            'Sedang Berlangsung',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        FutureBuilder<List<OngoingAnimeModel>>(
          future: extractAnimes(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              debugPrint('Error fetching anime: ${snapshot.error}');
              return const Center(child: Text('Error loading images'));
            }
            if (snapshot.hasData) {
              final animes = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.only(top: 12),
                child: SizedBox(
                  height: 280,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: animes.length + 1,
                    itemBuilder: (context, index) {
                      if (index < animes.length) {
                        final anime = animes[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: AnimeCarouselCard(
                            props: AnimeCarouselCardProps(
                              imageUrl: anime.thumb,
                              title: anime.title,
                              episode: 'Episode ${anime.episode}',
                              updateDay: anime.updatedDay,
                            ),
                          ),
                        );
                      } else if (index == animes.length) {
                        return const Padding(
                          padding: EdgeInsets.only(right: 16),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }

  Future<List<OngoingAnimeModel>> extractAnimes() async {
    final service = ApiService();
    try {
      final ongoingAnime = await service.getOngoingAnime(1);
      return ongoingAnime.content;
    } on Exception catch (e) {
      debugPrint('Error fetching ongoing anime: $e');
      return []; // Empty list on error
    }
  }
}
