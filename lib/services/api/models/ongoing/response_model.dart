import 'model.dart';

class ResponseOngoingModel {
  final bool success;
  final String message;
  final int currentPage;
  final List<OngoingAnimeModel> content;

  ResponseOngoingModel({
    required this.success,
    required this.message,
    required this.currentPage,
    required this.content,
  });

  factory ResponseOngoingModel.fromJson(Map<String, dynamic> json) {
    return ResponseOngoingModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      currentPage: json['currentPage'] as int,
      content: (json['content'] as List)
          .map((anime) => OngoingAnimeModel.fromJson(anime))
          .toList(),
    );
  }
}
