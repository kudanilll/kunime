import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/features/home/models/genre/ui_genre.dart';
import 'package:kunime/features/home/providers/home_provider.dart';
import 'package:kunime/features/home/models/genre/model.dart';
import 'package:kunime/services/core.dart';

final coreServiceProvider = Provider<CoreService>((_) => CoreService());

@Deprecated('Use uiGenreProvider instead')
final genreListProvider = FutureProvider<List<GenreModel>>((ref) async {
  final api = ref.read(apiServiceProvider);

  try {
    final res = await api.getGenres();
    return res.data;
  } catch (e) {
    ref.invalidateSelf();
    return <GenreModel>[];
  }
});

final uiGenreProvider = FutureProvider<List<UiGenre>>((ref) async {
  final api = ref.read(apiServiceProvider);
  final core = ref.read(coreServiceProvider);

  try {
    final apiFuture = api.getGenres();
    final coreFuture = core.getGenres();

    final apiRes = await apiFuture;
    final coreRes = await coreFuture;

    final apiGenres = apiRes.data;
    final coreGenres = coreRes.data;

    final imageMap = {for (final g in coreGenres) g.slug: g.imageUrl};
    return apiGenres.map((g) {
      return UiGenre(
        name: g.name,
        slug: g.slug,
        endpoint: g.endpoint,
        imageUrl: imageMap[g.slug],
      );
    }).toList();
  } catch (e, st) {
    debugPrint('uiGenreProvider error: $e\n$st');
    return [];
  }
});
