class RecommendationModel {
  final String animeId;
  final String title;
  final double rating;
  final String image;
  final String source;
  final DateTime updatedAt;

  RecommendationModel({
    required this.animeId,
    required this.title,
    required this.rating,
    required this.image,
    required this.source,
    required this.updatedAt,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) {
    final rawRating = json['rating'];

    double parsedRating;
    if (rawRating is int) {
      parsedRating = rawRating.toDouble();
    } else if (rawRating is double) {
      parsedRating = rawRating;
    } else {
      parsedRating = double.tryParse(rawRating.toString()) ?? 0.0;
    }

    return RecommendationModel(
      animeId: json['anime_id'] as String,
      title: json['title'] as String,
      rating: parsedRating,
      image: json['image'] as String,
      source: json['source'] as String,
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}
