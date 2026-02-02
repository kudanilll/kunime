import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/core/widgets/async_view.dart';
import 'package:kunime/features/home/providers/genre_provider.dart';
import 'widgets/genre_grid.dart';

class GenreSection extends ConsumerWidget {
  const GenreSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genres = ref.watch(genreListProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: AsyncView(
        value: genres,
        builder: (items) => GenreGrid(genres: items),
      ),
    );
  }
}
