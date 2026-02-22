import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kunime/features/home/models/completed/response_model.dart';
import 'package:kunime/features/home/models/genre/response_model.dart';
import 'package:kunime/features/home/models/ongoing/response_model.dart';
import 'package:kunime/features/home/models/search/response_model.dart';

class ApiService {
  static String apiUrl = const String.fromEnvironment('API_URL');
  static String apiKey = const String.fromEnvironment('API_KEY');

  Future<ResponseOngoingModel> getOngoingAnime(int page) async {
    final response = await http.get(
      Uri.parse('$apiUrl/ongoing-anime/$page'),
      headers: {'X-API-Key': apiKey},
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      return ResponseOngoingModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch ongoing anime');
    }
  }

  Future<ResponseCompletedModel> getCompletedAnime(int page) async {
    final response = await http.get(
      Uri.parse('$apiUrl/completed-anime/$page'),
      headers: {'X-API-Key': apiKey},
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      return ResponseCompletedModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch completed anime');
    }
  }

  Future<ResponseGenreModel> getGenres() async {
    final response = await http.get(
      Uri.parse('$apiUrl/genres'),
      headers: {'X-API-Key': apiKey},
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      return ResponseGenreModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch genres');
    }
  }

  Future<ResponseSearchModel> searchAnime(String query) async {
    final response = await http.get(
      Uri.parse('$apiUrl/search/$query'),
      headers: {'X-API-Key': apiKey},
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      return ResponseSearchModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to search anime');
    }
  }
}
