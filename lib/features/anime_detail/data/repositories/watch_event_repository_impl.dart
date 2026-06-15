import 'package:kunime/features/anime_detail/data/datasources/watch_event_api_client.dart';
import 'package:kunime/features/anime_detail/data/repositories/watch_event_repository.dart';

class WatchEventRepositoryImpl implements WatchEventRepository {
  const WatchEventRepositoryImpl({required this.apiClient});

  final WatchEventApiClient apiClient;

  @override
  Future<bool> recordWatch(String animeId, int episode) {
    return apiClient.recordWatch(animeId, episode);
  }
}
