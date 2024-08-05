import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kunime/api/models/ongoing/response_model.dart';

class ApiService {
  static const String baseUrl = 'https://kunime.vercel.app/api/v1';

  Future<ResponseOngoingModel> getOngoingAnime(int page) async {
    final response = await http.get(Uri.parse('$baseUrl/ongoing/$page'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      return ResponseOngoingModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch ongoing anime');
    }
  }
}
