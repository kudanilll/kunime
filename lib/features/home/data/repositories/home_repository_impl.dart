import 'package:flutter/foundation.dart';
import 'package:kunime/features/home/data/datasources/anime_api_client.dart';
import 'package:kunime/features/home/data/datasources/home_core_api_client.dart';
import 'package:kunime/features/home/data/repositories/home_repository.dart';
import 'package:kunime/features/home/models/genre/ui_genre.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';
import 'package:kunime/features/home/models/search/model.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({
    required AnimeApiClient animeApiClient,
    required HomeCoreApiClient homeCoreApiClient,
  }) : _animeApiClient = animeApiClient,
       _homeCoreApiClient = homeCoreApiClient;

  final AnimeApiClient _animeApiClient;
  final HomeCoreApiClient _homeCoreApiClient;

  @override
  Future<List<UiBanner>> fetchBanners() async {
    final response = await _homeCoreApiClient.getBanners();
    return response.data
        .map(
          (banner) => UiBanner(
            id: banner.id,
            imageUrl: banner.imageUrl,
            deepLink: banner.redirectUrl,
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<List<UiGenre>> fetchGenres() async {
    final apiFuture = _animeApiClient.getGenres();
    final coreFuture = _homeCoreApiClient.getGenres();

    final apiResponse = await apiFuture;
    final coreResponse = await coreFuture;

    final imageMap = {
      for (final genre in coreResponse.data) genre.slug: genre.imageUrl,
    };

    return apiResponse.data
        .map(
          (genre) => UiGenre(
            name: genre.name,
            slug: genre.slug,
            endpoint: genre.endpoint,
            imageUrl: imageMap[genre.slug],
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<List<UiOngoing>> fetchOngoingAnime({int page = 1}) async {
    final response = await _animeApiClient.getOngoingAnime(page);
    return response.data
        .map(
          (anime) => UiOngoing(
            title: anime.title,
            image: anime.image.trim(),
            episode: anime.episode,
            isNewRelease: anime.isNewRelease,
            day: anime.day,
            endpoint: anime.endpoint,
          ),
        )
        .where((anime) => anime.image.isNotEmpty)
        .toList(growable: false);
  }

  @override
  Future<List<UiCompleted>> fetchCompletedAnime({int page = 1}) async {
    final response = await _animeApiClient.getCompletedAnime(page);
    return response.data
        .map(
          (anime) => UiCompleted(
            title: anime.title,
            image: anime.image.trim(),
            score: anime.score,
            totalEpisode: anime.episodes,
            endpoint: anime.endpoint,
          ),
        )
        .where((anime) => anime.image.isNotEmpty)
        .toList(growable: false);
  }

  @override
  Future<List<UiRecommendation>> fetchRecommendations() async {
    final response = await _homeCoreApiClient.getRecommendations();
    return response.data
        .map(
          (anime) => UiRecommendation(
            title: anime.title,
            image: anime.image.trim(),
            score: anime.rating,
            endpoint: anime.animeId,
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<List<SearchAnimeModel>> searchAnime(String query) async {
    try {
      final response = await _animeApiClient.searchAnime(query);
      return response.data
          .map(
            (anime) => SearchAnimeModel(
              title: anime.title,
              status: anime.status,
              rating: anime.rating,
              genres: anime.genres,
              image: anime.image.trim(),
              endpoint: anime.endpoint,
            ),
          )
          .where((anime) => anime.image.isNotEmpty)
          .toList(growable: false);
    } catch (e) {
      throw Exception('Gagal mencari anime: $e');
    }
  }
}
