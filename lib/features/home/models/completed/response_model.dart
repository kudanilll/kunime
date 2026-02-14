import 'model.dart';

class ResponseCompletedModel {
  final int page;
  final List<CompletedAnimeModel> data;

  ResponseCompletedModel({required this.page, required this.data});

  factory ResponseCompletedModel.fromJson(Map<String, dynamic> json) =>
      ResponseCompletedModel(
        page: json['page'] as int,
        data: (json['data'] as List<dynamic>)
            .map(
              (anime) =>
                  CompletedAnimeModel.fromJson(anime as Map<String, dynamic>),
            )
            .toList(),
      );
}
