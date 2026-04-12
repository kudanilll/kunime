import 'package:kunime/features/home/models/search/model.dart';

abstract class SearchHistoryRepository {
  Future<List<SearchAnimeModel>> load();
  Future<void> save(List<SearchAnimeModel> items);
}
