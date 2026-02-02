class OngoingAnimeModel {
  final String title;
  final String image;
  final int episode;
  final String date;
  final String day;
  final String endpoint;

  OngoingAnimeModel({
    required this.title,
    required this.image,
    required this.episode,
    required this.date,
    required this.day,
    required this.endpoint,
  });

  factory OngoingAnimeModel.fromJson(Map<String, dynamic> json) =>
      OngoingAnimeModel(
        title: json['title'] as String,
        image: json['image'] as String,
        episode: json['episode'] as int,
        date: json['date'] as String,
        day: json['day'] as String,
        endpoint: json['endpoint'] as String,
      );
}
