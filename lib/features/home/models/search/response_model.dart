import 'model.dart';

class ResponseSearchModel {
  final String query;
  final List<SearchAnimeModel> data;

  ResponseSearchModel({required this.query, required this.data});

  factory ResponseSearchModel.fromJson(Map<String, dynamic> json) =>
      ResponseSearchModel(
        query: json['query'] as String,
        data: (json['data'] as List<dynamic>)
            .map((e) => SearchAnimeModel.fromJson(e))
            .toList(),
      );
}
