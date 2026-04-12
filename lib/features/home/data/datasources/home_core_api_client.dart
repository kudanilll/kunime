import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kunime/features/home/models/banner/response_model.dart';
import 'package:kunime/features/home/models/genre_core/response_model.dart';
import 'package:kunime/features/home/models/recommendation/response_model.dart';

class HomeCoreApiClient {
  static String baseUrl = const String.fromEnvironment('CORE_API_URL');
  static String apiKey = const String.fromEnvironment('CORE_API_KEY');

  Future<ResponseRecommendationModel> getRecommendations() async {
    final response = await http.get(
      Uri.parse('$baseUrl/recommendations'),
      headers: {'X-API-Key': apiKey},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch recommendations from core');
    }

    final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
    return ResponseRecommendationModel.fromJson(jsonData);
  }

  Future<ResponseBannerModel> getBanners() async {
    final response = await http.get(
      Uri.parse('$baseUrl/banners'),
      headers: {'X-API-Key': apiKey},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch banners from core');
    }

    final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
    return ResponseBannerModel.fromJson(jsonData);
  }

  Future<ResponseGenreCoreModel> getGenres() async {
    final response = await http.get(
      Uri.parse('$baseUrl/genres'),
      headers: {'X-API-Key': apiKey},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch genres from core');
    }

    final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
    return ResponseGenreCoreModel.fromJson(jsonData);
  }
}
