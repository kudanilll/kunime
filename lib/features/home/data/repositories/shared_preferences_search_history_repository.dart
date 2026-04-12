import 'dart:convert';

import 'package:kunime/features/home/data/repositories/search_history_repository.dart';
import 'package:kunime/features/home/models/search/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesSearchHistoryRepository
    implements SearchHistoryRepository {
  static const _historyKey = 'search_history_v1';

  @override
  Future<List<SearchAnimeModel>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_historyKey) ?? const <String>[];

    return raw
        .map((item) => SearchAnimeModel.fromJson(jsonDecode(item)))
        .toList(growable: false);
  }

  @override
  Future<void> save(List<SearchAnimeModel> items) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = items.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(_historyKey, encoded);
  }
}
