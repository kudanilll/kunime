import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';
import 'package:kunime/services/api.dart';

final apiServiceProvider = Provider<ApiService>((_) => ApiService());

/// TODO: ganti mock ini ke repository beneran (ref.watch(animeRepositoryProvider), dll.)
List<String> _readBannerUrlsFromEnv() {
  final e = dotenv.env;
  final raw = <String?>[
    e['BANNER_1_URL'],
    e['BANNER_2_URL'],
    e['BANNER_3_URL'],
    e['BANNER_4_URL'],
    e['BANNER_5_URL'],
    e['BANNER_6_URL'],
  ];

  bool valid(String? u) {
    if (u == null) return false;
    final s = u.trim();
    if (s.isEmpty) return false;
    if (s.toLowerCase() == 'null') return false;
    final uri = Uri.tryParse(s);
    return uri != null && (uri.isScheme('http') || uri.isScheme('https'));
  }

  final urls = raw.where(valid).map((s) => s!.trim()).toList();

  // Fallback
  if (urls.isEmpty) {
    return List.generate(3, (i) => 'https://picsum.photos/1200/400?banner=$i');
  }
  return urls;
}

final bannerListProvider = FutureProvider<List<UiBanner>>((ref) async {
  final urls = _readBannerUrlsFromEnv();
  return List.generate(
    urls.length,
    (i) => UiBanner(id: 'banner_$i', imageUrl: urls[i]),
  );
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
    // Jangan lempar error—balikkan list kosong supaya UI tetap render.
    return const <UiOngoing>[];
  }
});

final categoriesProvider = FutureProvider<List<UiCategory>>((ref) async {
  return const [
    UiCategory(id: 'ongoing', label: 'Ongoing', icon: FontAwesomeIcons.fire),
    UiCategory(
      id: 'new',
      label: 'Baru Rilis',
      icon: FontAwesomeIcons.wandMagicSparkles,
    ),
    UiCategory(id: 'popular', label: 'Populer', icon: FontAwesomeIcons.star),
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
