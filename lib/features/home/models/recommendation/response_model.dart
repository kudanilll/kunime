import 'model.dart';

class ResponseRecommendationModel {
  final List<RecommendationModel> data;

  ResponseRecommendationModel({required this.data});

  factory ResponseRecommendationModel.fromJson(Map<String, dynamic> json) {
    final rawList = json['data'] as List<dynamic>? ?? [];
    return ResponseRecommendationModel(
      data: rawList.map((e) => RecommendationModel.fromJson(e)).toList(),
    );
  }
}
