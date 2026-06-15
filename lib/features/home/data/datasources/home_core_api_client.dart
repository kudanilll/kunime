import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:kunime/features/home/models/banner/response_model.dart';
import 'package:kunime/features/home/models/genre_core/response_model.dart';
import 'package:kunime/features/home/models/recommendation/response_model.dart';

class HomeCoreApiClient {
  static const String baseUrl = String.fromEnvironment('CORE_API_URL');
  static const String apiKey = String.fromEnvironment('CORE_API_KEY');
  static const _timeout = Duration(seconds: 15);
  static final _client = http.Client();

  Future<ResponseRecommendationModel> getRecommendations() async {
    final response = await _get('$baseUrl/recommendations');
    return ResponseRecommendationModel.fromJson(
      _decodeJson(response) as Map<String, dynamic>,
    );
  }

  Future<ResponseBannerModel> getBanners() async {
    final response = await _get('$baseUrl/banners');
    return ResponseBannerModel.fromJson(
      _decodeJson(response) as Map<String, dynamic>,
    );
  }

  Future<ResponseGenreCoreModel> getGenres() async {
    final response = await _get('$baseUrl/genres');
    return ResponseGenreCoreModel.fromJson(
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
