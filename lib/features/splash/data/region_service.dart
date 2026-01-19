import 'dart:convert';
import 'package:http/http.dart' as http;

class RegionService {
  static const _endpoint = 'https://ipapi.co/json/';

  Future<String?> detectCountryCode() async {
    try {
      final res = await http.get(Uri.parse(_endpoint));
      if (res.statusCode != 200) return null;

      final json = jsonDecode(res.body) as Map<String, dynamic>;
      return json['country_code'] as String?;
    } catch (_) {
      return null;
    }
  }
}
