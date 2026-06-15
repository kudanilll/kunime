import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:kunime/features/anime_detail/models/anime_detail_response_model.dart';
import 'package:kunime/features/anime_detail/models/episode_response_model.dart';

class AnimeDetailApiClient {
  static const String baseUrl = String.fromEnvironment('API_URL');
  static const String apiKey = String.fromEnvironment('API_KEY');
  static const _timeout = Duration(seconds: 15);
  static final _client = http.Client();

  Future<AnimeDetailResponse> getAnimeDetail(String slug) async {
    final response = await _get('$baseUrl/anime/$slug');
    return AnimeDetailResponse.fromJson(
      _decodeJson(response) as Map<String, dynamic>,
    );
  }

  Future<EpisodeListResponse> getEpisodes(String slug) async {
    final response = await _get('$baseUrl/anime/$slug/episodes');
    return EpisodeListResponse.fromJson(
      _decodeJson(response) as Map<String, dynamic>,
    );
  }

  Future<http.Response> _get(String url) async {
    try {
      final response = await _client
          .get(Uri.parse(url), headers: {'X-API-Key': apiKey})
          .timeout(_timeout);

      if (response.statusCode != 200) {
        throw Exception('Request failed with status ${response.statusCode}');
      }
      return response;
    } on TimeoutException {
      throw Exception('Request timed out');
    } on SocketException {
      throw Exception('No internet connection');
    } on HttpException {
      throw Exception('HTTP request failed');
    }
  }

  dynamic _decodeJson(http.Response response) {
    try {
      return jsonDecode(response.body);
    } on FormatException {
      throw Exception('Invalid response format');
    }
  }
}
