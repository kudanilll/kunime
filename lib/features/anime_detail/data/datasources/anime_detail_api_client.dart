import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kunime/features/anime_detail/models/anime_detail_response_model.dart';
import 'package:kunime/features/anime_detail/models/episode_response_model.dart';

class AnimeDetailApiClient {
  static String baseUrl = const String.fromEnvironment('API_URL');
  static String apiKey = const String.fromEnvironment('API_KEY');

  Future<AnimeDetailResponse> getAnimeDetail(String slug) async {
    final response = await http.get(
      Uri.parse('$baseUrl/anime/$slug'),
      headers: {'X-API-Key': apiKey},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch anime detail');
    }

    final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
    return AnimeDetailResponse.fromJson(jsonData);
  }

  Future<EpisodeListResponse> getEpisodes(String slug) async {
    final response = await http.get(
      Uri.parse('$baseUrl/anime/$slug/episodes'),
      headers: {'X-API-Key': apiKey},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch episodes');
    }

    final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
    return EpisodeListResponse.fromJson(jsonData);
  }
}
