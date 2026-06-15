import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class WatchEventApiClient {
  static const String baseUrl = String.fromEnvironment('CORE_API_URL');
  static const String apiKey = String.fromEnvironment('CORE_API_KEY');
  static const String deviceId = String.fromEnvironment('DEVICE_ID', defaultValue: 'unknown');
  static const _timeout = Duration(seconds: 15);
  static final _client = http.Client();

  Future<bool> recordWatch(String animeId, int episode) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/api/v1/events/watch'),
        headers: {
          'X-API-Key': apiKey,
          'X-Device-Id': deviceId,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'anime_id': animeId,
          'episode': episode,
        }),
      ).timeout(_timeout);

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to record watch event: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('Request timed out');
    } on SocketException {
      throw Exception('No internet connection');
    } on HttpException {
      throw Exception('HTTP request failed');
    }
  }
}
