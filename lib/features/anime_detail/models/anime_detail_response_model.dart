class AnimeDetailResponse {
  final String title;
  final String japaneseTitle;
  final String score;
  final String type;
  final String status;
  final String totalEpisode;
  final String duration;
  final String releaseDate;
  final String studio;
  final List<String> producers;
  final List<String> genres;
  final String image;
  final String synopsis;

  AnimeDetailResponse({
    required this.title,
    required this.japaneseTitle,
    required this.score,
    required this.type,
    required this.status,
    required this.totalEpisode,
    required this.duration,
    required this.releaseDate,
    required this.studio,
    required this.producers,
    required this.genres,
    required this.image,
    required this.synopsis,
  });

  factory AnimeDetailResponse.fromJson(Map<String, dynamic> json) {
    return AnimeDetailResponse(
      title: json['title'] as String? ?? '',
      japaneseTitle: json['japanese_title'] as String? ?? '',
      score: json['score'] as String? ?? '0',
      type: json['type'] as String? ?? '',
      status: json['status'] as String? ?? '',
      totalEpisode: json['total_episode'] as String? ?? '0',
      duration: json['duration'] as String? ?? '',
      releaseDate: json['release_date'] as String? ?? '',
      studio: json['studio'] as String? ?? '',
      producers: (json['producers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      image: json['image'] as String? ?? '',
      synopsis: json['synopsis'] as String? ?? '',
    );
  }
}