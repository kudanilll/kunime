class EpisodeListResponse {
  final String animeSlug;
  final List<EpisodeItem> episodes;

  EpisodeListResponse({
    required this.animeSlug,
    required this.episodes,
  });

  factory EpisodeListResponse.fromJson(Map<String, dynamic> json) {
    return EpisodeListResponse(
      animeSlug: json['anime_slug'] as String? ?? '',
      episodes: (json['episodes'] as List<dynamic>?)
              ?.map((e) => EpisodeItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class EpisodeItem {
  final int episode;
  final String slug;

  EpisodeItem({
    required this.episode,
    required this.slug,
  });

  factory EpisodeItem.fromJson(Map<String, dynamic> json) {
    return EpisodeItem(
      episode: json['episode'] as int? ?? 0,
      slug: json['slug'] as String? ?? '',
    );
  }
}