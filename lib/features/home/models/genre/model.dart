class GenreModel {
  final String name;
  final String slug;
  final String endpoint;

  GenreModel({required this.name, required this.slug, required this.endpoint});

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
    name: json['name'] as String,
    slug: json['slug'] as String,
    endpoint: json['endpoint'] as String,
  );
}
