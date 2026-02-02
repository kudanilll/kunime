import 'model.dart';

class ResponseOngoingModel {
  final int page;
  final List<OngoingAnimeModel> data;

  ResponseOngoingModel({required this.page, required this.data});

  factory ResponseOngoingModel.fromJson(Map<String, dynamic> json) =>
      ResponseOngoingModel(
        page: json['page'] as int,
        data: (json['data'] as List<dynamic>)
            .map(
              (anime) =>
                  OngoingAnimeModel.fromJson(anime as Map<String, dynamic>),
            )
            .toList(),
      );
}
