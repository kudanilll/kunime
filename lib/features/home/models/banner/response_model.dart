import 'model.dart';

class ResponseBannerModel {
  final List<BannerModel> data;

  ResponseBannerModel({required this.data});

  factory ResponseBannerModel.fromJson(Map<String, dynamic> json) =>
      ResponseBannerModel(
        data: (json['data'] as List<dynamic>)
            .map((e) => BannerModel.fromJson(e))
            .toList(),
      );
}
