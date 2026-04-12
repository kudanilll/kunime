import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/core/widgets/svg_icon.dart';
import 'package:kunime/features/home/data/datasources/anime_api_client.dart';
import 'package:kunime/features/home/data/datasources/home_core_api_client.dart';
import 'package:kunime/features/home/data/repositories/home_repository.dart';
import 'package:kunime/features/home/data/repositories/home_repository_impl.dart';
import 'package:kunime/features/home/models/genre/ui_genre.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';

final animeApiClientProvider = Provider<AnimeApiClient>((ref) {
  return AnimeApiClient();
});

final homeCoreApiClientProvider = Provider<HomeCoreApiClient>((ref) {
  return HomeCoreApiClient();
});

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepositoryImpl(
    animeApiClient: ref.watch(animeApiClientProvider),
    homeCoreApiClient: ref.watch(homeCoreApiClientProvider),
  );
});

final homeBannerProvider = FutureProvider<List<UiBanner>>((ref) async {
  return ref.watch(homeRepositoryProvider).fetchBanners();
});

final ongoingAnimeListProvider = FutureProvider<List<UiOngoing>>((ref) async {
  return ref.watch(homeRepositoryProvider).fetchOngoingAnime();
});

final homeRecommendationProvider = FutureProvider<List<UiRecommendation>>((
  ref,
) async {
  return ref.watch(homeRepositoryProvider).fetchRecommendations();
});

final homeGenreProvider = FutureProvider<List<UiGenre>>((ref) async {
  return ref.watch(homeRepositoryProvider).fetchGenres();
});

final homeCategoryProvider = Provider<List<UiCategory>>((ref) {
  return const [
    UiCategory(id: 'ongoing', label: 'Sedang Tayang', icon: SvgIcon.fireIcon),
    UiCategory(
      id: 'completed',
      label: 'Sudah Tamat',
      icon: SvgIcon.checkDoubleIcon,
    ),
    UiCategory(id: 'genre', label: 'Genre', icon: SvgIcon.shapesIcon),
    UiCategory(id: 'favorite', label: 'Tersimpan', icon: SvgIcon.bookmarkIcon),
  ];
});
