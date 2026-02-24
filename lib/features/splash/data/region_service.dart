import 'dart:convert';
import 'package:http/http.dart' as http;

class RegionService {
  static const _endpoint = 'https://ipwho.is/';

  Future<String?> detectCountryCode() async {
    try {
      final res = await http.get(Uri.parse(_endpoint));
      if (res.statusCode != 200) return null;

      final json = jsonDecode(res.body);
      return json['country_code'];
    } catch (_) {
      return null;
    }
  }
}
