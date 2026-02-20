import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:kunime/features/home/models/recommendation/response_model.dart';

class CoreService {
  static String baseUrl = '${dotenv.env['CORE_API_URL']}';

  Future<ResponseRecommendationModel> getRecommendations() async {
    final response = await http.get(
      Uri.parse('$baseUrl/recommendations'),
      headers: {'X-API-Key': dotenv.env['CORE_API_KEY']!},
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      return ResponseRecommendationModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch recommendations from core');
    }
  }
}
