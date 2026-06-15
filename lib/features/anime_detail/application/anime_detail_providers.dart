import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/features/anime_detail/data/datasources/anime_detail_api_client.dart';
import 'package:kunime/features/anime_detail/data/datasources/watch_event_api_client.dart';
import 'package:kunime/features/anime_detail/data/repositories/anime_detail_repository.dart';
import 'package:kunime/features/anime_detail/data/repositories/anime_detail_repository_impl.dart';
import 'package:kunime/features/anime_detail/data/repositories/watch_event_repository.dart';
import 'package:kunime/features/anime_detail/data/repositories/watch_event_repository_impl.dart';
import 'package:kunime/features/anime_detail/models/anime_detail_response_model.dart';
import 'package:kunime/features/anime_detail/models/episode_response_model.dart';

final animeDetailApiClientProvider = Provider<AnimeDetailApiClient>((ref) {
  return AnimeDetailApiClient();
});

final animeDetailRepositoryProvider = Provider<AnimeDetailRepository>((ref) {
  return AnimeDetailRepositoryImpl(
    apiClient: ref.watch(animeDetailApiClientProvider),
  );
});

final animeDetailProvider = FutureProvider.family<AnimeDetailResponse, String>(
  (ref, slug) => ref.watch(animeDetailRepositoryProvider).getAnimeDetail(slug),
);

final animeEpisodesProvider = FutureProvider.family<EpisodeListResponse, String>(
  (ref, slug) => ref.watch(animeDetailRepositoryProvider).getEpisodes(slug),
);

final watchEventApiClientProvider = Provider<WatchEventApiClient>((ref) {
  return WatchEventApiClient();
});

final watchEventRepositoryProvider = Provider<WatchEventRepository>((ref) {
  return WatchEventRepositoryImpl(
    apiClient: ref.watch(watchEventApiClientProvider),
  );
});

class WatchEventNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<bool> recordWatch(String animeId, int episode) async {
    state = const AsyncValue.loading();
    
    try {
      final repo = ref.read(watchEventRepositoryProvider);
      final success = await repo.recordWatch(animeId, episode);
      
      if (success) {
        state = const AsyncValue.data(null);
        return true;
      } else {
        state = AsyncValue.error('Failed to record watch event', StackTrace.current);
        return false;
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}

final watchEventProvider = AsyncNotifierProvider<WatchEventNotifier, void>(
  WatchEventNotifier.new,
);