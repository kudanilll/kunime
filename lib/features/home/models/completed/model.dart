class CompletedAnimeModel {
  final String title;
  final int episodes;
  final double score;
  final String date;
  final String image;
  final String endpoint;

  CompletedAnimeModel({
    required this.title,
    required this.episodes,
    required this.score,
    required this.date,
    required this.image,
    required this.endpoint,
  });

  factory CompletedAnimeModel.fromJson(Map<String, dynamic> json) =>
      CompletedAnimeModel(
        title: json['title'] as String,
        episodes: json['episodes'] as int,
        score: json['score'] as double,
        date: json['date'] as String,
        image: json['image'] as String,
        endpoint: json['endpoint'] as String,
      );
}
