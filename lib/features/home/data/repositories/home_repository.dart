import 'package:kunime/features/home/models/genre/ui_genre.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';
import 'package:kunime/features/home/models/search/model.dart';

abstract class HomeRepository {
  Future<List<UiBanner>> fetchBanners();
  Future<List<UiOngoing>> fetchOngoingAnime({int page = 1});
  Future<List<UiRecommendation>> fetchRecommendations();
  Future<List<UiGenre>> fetchGenres();
  Future<List<SearchAnimeModel>> searchAnime(String query);
}
