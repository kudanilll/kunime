import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kunime/features/home/models/banner/response_model.dart';
import 'package:kunime/features/home/models/genre_core/response_model.dart';
import 'package:kunime/features/home/models/recommendation/response_model.dart';

class CoreService {
  static String apiUrl = const String.fromEnvironment('CORE_API_URL');
  static String apiKey = const String.fromEnvironment('CORE_API_KEY');

  Future<ResponseRecommendationModel> getRecommendations() async {
    final response = await http.get(
      Uri.parse('$apiUrl/recommendations'),
      headers: {'X-API-Key': apiKey},
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      return ResponseRecommendationModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch recommendations from core');
    }
  }

  Future<ResponseBannerModel> getBanners() async {
    final response = await http.get(
      Uri.parse('$apiUrl/banners'),
      headers: {'X-API-Key': apiKey},
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      return ResponseBannerModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch banners from core');
    }
  }

  Future<ResponseGenreCoreModel> getGenres() async {
    final response = await http.get(
      Uri.parse('$apiUrl/genres'),
      headers: {'X-API-Key': apiKey},
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      return ResponseGenreCoreModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch genres from core');
    }
  }
}
