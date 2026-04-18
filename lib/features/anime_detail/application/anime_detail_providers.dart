import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:kunime/features/anime_detail/data/datasources/anime_detail_api_client.dart';
import 'package:kunime/features/anime_detail/data/repositories/anime_detail_repository.dart';
import 'package:kunime/features/anime_detail/data/repositories/anime_detail_repository_impl.dart';
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

class WatchEventNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<bool> recordWatch(String animeId, int episode) async {
    state = const AsyncValue.loading();
    
    try {
      const baseUrl = String.fromEnvironment('CORE_API_URL');
      const apiKey = String.fromEnvironment('CORE_API_KEY');
      const deviceId = String.fromEnvironment('DEVICE_ID', defaultValue: 'unknown');

      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/events/watch'),
        headers: {
          'X-API-Key': apiKey,
          'X-Device-Id': deviceId,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'anime_id': animeId,
          'episode': episode,
        }),
      );

      if (response.statusCode == 200) {
        state = const AsyncValue.data(null);
        return true;
      } else {
        state = AsyncValue.error('Failed to record watch event', StackTrace.current);
        return false;
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return false;
    }
  }
}

final watchEventProvider = AsyncNotifierProvider<WatchEventNotifier, void>(
  WatchEventNotifier.new,
);