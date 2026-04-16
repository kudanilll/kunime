import 'package:kunime/features/anime_detail/models/anime_detail_response_model.dart';
import 'package:kunime/features/anime_detail/models/episode_response_model.dart';

abstract class AnimeDetailRepository {
  Future<AnimeDetailResponse> getAnimeDetail(String slug);
  Future<EpisodeListResponse> getEpisodes(String slug);
}