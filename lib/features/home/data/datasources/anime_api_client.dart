import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:kunime/features/home/models/completed/response_model.dart';
import 'package:kunime/features/home/models/genre/response_model.dart';
import 'package:kunime/features/home/models/ongoing/response_model.dart';
import 'package:kunime/features/home/models/search/response_model.dart';

class AnimeApiClient {
  static const String baseUrl = String.fromEnvironment('API_URL');
  static const String apiKey = String.fromEnvironment('API_KEY');
  static const _timeout = Duration(seconds: 15);
  static final _client = http.Client();

  Future<ResponseOngoingModel> getOngoingAnime(int page) async {
    final response = await _get('$baseUrl/ongoing-anime/$page');
    return ResponseOngoingModel.fromJson(
      _decodeJson(response) as Map<String, dynamic>,
    );
  }

  Future<ResponseCompletedModel> getCompletedAnime(int page) async {
    final response = await _get('$baseUrl/completed-anime/$page');
    return ResponseCompletedModel.fromJson(
      _decodeJson(response) as Map<String, dynamic>,
    );
  }

  Future<ResponseGenreModel> getGenres() async {
    final response = await _get('$baseUrl/genres');
    return ResponseGenreModel.fromJson(
      _decodeJson(response) as Map<String, dynamic>,
    );
  }

  Future<ResponseSearchModel> searchAnime(String query) async {
    final encodedQuery = Uri.encodeComponent(query);
    final response = await _get('$baseUrl/search/$encodedQuery');
    return ResponseSearchModel.fromJson(
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
