import 'model.dart';

class ResponseGenreModel {
  final List<GenreModel> data;

  ResponseGenreModel({required this.data});

  factory ResponseGenreModel.fromJson(Map<String, dynamic> json) =>
      ResponseGenreModel(
        data: (json['data'] as List<dynamic>)
            .map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
