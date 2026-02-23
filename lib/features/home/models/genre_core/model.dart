class GenreCoreModel {
  final String slug;
  final String imageUrl;

  GenreCoreModel({required this.slug, required this.imageUrl});

  factory GenreCoreModel.fromJson(Map<String, dynamic> json) {
    return GenreCoreModel(
      slug: json['slug'] as String,
      imageUrl: json['image_url'] as String,
    );
  }
}
