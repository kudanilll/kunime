class SearchAnimeModel {
  final String title;
  final String status;
  final String rating;
  final List<String> genres;
  final String image;
  final String endpoint;

  const SearchAnimeModel({
    required this.title,
    required this.status,
    required this.rating,
    required this.genres,
    required this.image,
    required this.endpoint,
  });

  factory SearchAnimeModel.fromJson(Map<String, dynamic> json) {
    return SearchAnimeModel(
      title: json['title'] as String,
      status: json['status'] as String,
      rating: json['rating'] as String,
      genres: List<String>.from(json['genres'] as List),
      image: json['image'] as String,
      endpoint: json['endpoint'] as String,
    );
  }
}
