import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:kunime/core/widgets/svg_icon.dart';
import 'package:kunime/features/home/data/banner_repository.dart';
import 'package:kunime/features/home/data/banner_repository_impl.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';
import 'package:kunime/services/api.dart';

final apiServiceProvider = Provider<ApiService>((_) => ApiService());

final bannerRepositoryProvider = Provider<BannerRepository>((ref) {
  return BannerRepositoryImpl();
});

final bannerListProvider = FutureProvider<List<UiBanner>>((ref) async {
  final repo = ref.watch(bannerRepositoryProvider);
  return repo.getBanners();
});

final ongoingAnimeProvider = FutureProvider<List<UiOngoing>>((ref) async {
  final api = ref.watch(apiServiceProvider);

  try {
    final res = await api.getOngoingAnime(1); // page 1
    final list = res.data;

    if (list.isEmpty) return const <UiOngoing>[];

    return List<UiOngoing>.generate(list.length, (i) {
      final a = list[i];
      return UiOngoing(
        title: a.title,
        image: (a.image).trim(),
        episode: a.episode,
        day: a.day,
        endpoint: a.endpoint,
      );
    }).where((x) => x.image.isNotEmpty).toList();
  } catch (e, st) {
    debugPrint('ongoingAnimeProvider error: $e\n$st');
    return const <UiOngoing>[];
  }
});

final categoriesProvider = FutureProvider<List<UiCategory>>((ref) async {
  return [
    UiCategory(id: 'ongoing', label: 'Berlangsung', icon: SvgIcon.fireIcon),
    UiCategory(
      id: 'completed',
      label: 'Selesai',
      icon: SvgIcon.checkDoubleIcon,
    ),
    UiCategory(id: 'genre', label: 'Genre', icon: SvgIcon.shapesIcon),
    UiCategory(id: 'favorite', label: 'Favorit', icon: SvgIcon.bookmarkIcon),
    UiCategory(id: 'history', label: 'Riwayat', icon: SvgIcon.historyIcon),
  ];
});

/// Saving selected category id
@Deprecated('Use homeStateProvider instead')
final selectedCategoryIdProvider = StateProvider<String?>((ref) => null);

final recommendationProvider = FutureProvider<List<UiRecommendation>>((
  ref,
) async {
  final api = ref.watch(apiServiceProvider);

  try {
    // generate request page 1–5
    final futures = List.generate(5, (i) => api.getCompletedAnime(i + 1));

    // fetch all pages in parallel
    final responses = await Future.wait(futures, eagerError: false);

    // flatten data
    final allAnimes = responses.expand((res) => res.data).toList();

    if (allAnimes.isEmpty) {
      return const <UiRecommendation>[];
    }

    // sort by score DESC
    allAnimes.sort((a, b) => b.score.compareTo(a.score));

    // take top 6
    return allAnimes.take(6).map((anime) {
      return UiRecommendation(
        title: anime.title,
        image: anime.image.trim(),
        score: anime.score,
        endpoint: anime.endpoint,
      );
    }).toList();
  } catch (e, st) {
    debugPrint('recommendationProvider error: $e\n$st');
    return const <UiRecommendation>[];
  }
});
