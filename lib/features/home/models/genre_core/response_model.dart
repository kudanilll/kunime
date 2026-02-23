import 'model.dart';

class ResponseGenreCoreModel {
  final List<GenreCoreModel> data;

  ResponseGenreCoreModel({required this.data});

  factory ResponseGenreCoreModel.fromJson(Map<String, dynamic> json) {
    return ResponseGenreCoreModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => GenreCoreModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
