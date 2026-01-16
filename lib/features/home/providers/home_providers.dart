import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  return const [
    UiCategory(id: 'ongoing', label: 'Ongoing', icon: FontAwesomeIcons.fire),
    UiCategory(
      id: 'completed',
      label: 'Selesai',
      icon: FontAwesomeIcons.checkDouble,
    ),
    UiCategory(id: 'genre', label: 'Genre', icon: FontAwesomeIcons.shapes),
    UiCategory(
      id: 'favorite',
      label: 'Favorit',
      icon: FontAwesomeIcons.bookmark,
    ),
    UiCategory(
      id: 'history',
      label: 'Riwayat',
      icon: FontAwesomeIcons.clockRotateLeft,
    ),
  ];
});

/// Saving selected category id
final selectedCategoryIdProvider = StateProvider<String?>((ref) => null);

final trendingAnimeProvider = FutureProvider<List<UiTrending>>((ref) async {
  // TODO: fetch dari API dan map ke UiTrending
  await Future<void>.delayed(const Duration(milliseconds: 250));
  return const [
    UiTrending(
      id: 'aot',
      title: 'Attack on Titan',
      imageUrl: 'https://cdn.myanimelist.net/images/anime/1000/110531.jpg',
      episodeCount: 75,
    ),
    UiTrending(
      id: 'knyn',
      title: 'Demon Slayer',
      imageUrl: 'https://cdn.myanimelist.net/images/anime/1286/99889.jpg',
      episodeCount: 26,
    ),
    UiTrending(
      id: 'mha',
      title: 'My Hero Academia',
      imageUrl: 'https://cdn.myanimelist.net/images/anime/1911/113611.jpg',
      episodeCount: 113,
    ),
    UiTrending(
      id: 'op',
      title: 'One Piece',
      imageUrl: 'https://cdn.myanimelist.net/images/anime/1244/138851.jpg',
      episodeCount: 1000,
    ),
    UiTrending(
      id: 'ns',
      title: 'Naruto Shippuden',
      imageUrl: 'https://cdn.myanimelist.net/images/anime/1565/111305.jpg',
      episodeCount: 24,
    ),
  ];
});
