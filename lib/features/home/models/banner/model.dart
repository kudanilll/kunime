class BannerModel {
  final String id;
  final String title;
  final String imageUrl;
  final String redirectUrl;

  const BannerModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.redirectUrl,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['image_url'] as String,
      redirectUrl: json['redirect_url'] as String,
    );
  }
}
