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

  factory CompletedAnimeModel.fromJson(Map<String, dynamic> json) {
    final rawScore = json['score'];

    double parsedScore;
    if (rawScore is int) {
      parsedScore = rawScore.toDouble();
    } else if (rawScore is double) {
      parsedScore = rawScore;
    } else if (rawScore is String) {
      parsedScore = double.tryParse(rawScore) ?? 0.0;
    } else {
      parsedScore = 0.0;
    }

    return CompletedAnimeModel(
      title: json['title'] as String,
      episodes: json['episodes'] as int,
      score: parsedScore,
      date: json['date'] as String,
      image: json['image'] as String,
      endpoint: json['endpoint'] as String,
    );
  }
}
