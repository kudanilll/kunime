import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:kunime/features/home/models/genre/response_model.dart';
import 'package:kunime/features/home/models/ongoing/response_model.dart';
import 'package:kunime/features/home/models/search/response_model.dart';

class ApiService {
  static String baseUrl = '${dotenv.env['API_URL']}';

  Future<ResponseOngoingModel> getOngoingAnime(int page) async {
    final response = await http.get(
      Uri.parse('$baseUrl/ongoing-anime/$page'),
      headers: {'X-API-Key': dotenv.env['API_KEY']!},
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      return ResponseOngoingModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch ongoing anime');
    }
  }

  Future<ResponseGenreModel> getGenres() async {
    final response = await http.get(
      Uri.parse('$baseUrl/genres'),
      headers: {'X-API-Key': dotenv.env['API_KEY']!},
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
      Uri.parse('$baseUrl/search/$query'),
      headers: {'X-API-Key': dotenv.env['API_KEY']!},
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      return ResponseSearchModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to search anime');
    }
  }
}
