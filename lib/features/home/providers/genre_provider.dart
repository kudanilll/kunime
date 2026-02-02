import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/features/home/providers/home_provider.dart';
import 'package:kunime/features/home/models/genre/model.dart';

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
