import 'model.dart';

class ResponseOngoingModel {
  final int page;
  final List<OngoingAnimeModel> data;

  ResponseOngoingModel({required this.page, required this.data});

  factory ResponseOngoingModel.fromJson(Map<String, dynamic> json) {
    return ResponseOngoingModel(
      page: json['page'] as int,
      data: (json['data'] as List)
          .map((anime) => OngoingAnimeModel.fromJson(anime))
          .toList(),
    );
  }
}
