class OngoingAnimeModel {
  final String title;
  final String thumb;
  final int episode;
  final String updatedOn;
  final String updatedDay;
  final String endpoint;

  OngoingAnimeModel({
    required this.title,
    required this.thumb,
    required this.episode,
    required this.updatedOn,
    required this.updatedDay,
    required this.endpoint,
  });

  factory OngoingAnimeModel.fromJson(Map<String, dynamic> json) {
    return OngoingAnimeModel(
      title: json['title'] as String,
      thumb: json['thumb'] as String,
      episode: json['episode'] as int,
      updatedOn: json['updated_on'] as String,
      updatedDay: json['updated_day'] as String,
      endpoint: json['endpoint'] as String,
    );
  }
}
