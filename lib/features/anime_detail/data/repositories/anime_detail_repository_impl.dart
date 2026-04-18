import 'package:kunime/features/anime_detail/data/datasources/anime_detail_api_client.dart';
import 'package:kunime/features/anime_detail/data/repositories/anime_detail_repository.dart';
import 'package:kunime/features/anime_detail/models/anime_detail_response_model.dart';
import 'package:kunime/features/anime_detail/models/episode_response_model.dart';

class AnimeDetailRepositoryImpl implements AnimeDetailRepository {
  AnimeDetailRepositoryImpl({required AnimeDetailApiClient apiClient})
      : _apiClient = apiClient;

  final AnimeDetailApiClient _apiClient;

  @override
  Future<AnimeDetailResponse> getAnimeDetail(String slug) {
    return _apiClient.getAnimeDetail(slug);
  }

  @override
  Future<EpisodeListResponse> getEpisodes(String slug) {
    return _apiClient.getEpisodes(slug);
  }
}