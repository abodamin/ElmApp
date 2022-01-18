// To parse this JSON data, do
//
//     final errorTrendingMoviesModel = errorTrendingMoviesModelFromJson(jsonString);

import 'dart:convert';

ErrorTrendingMoviesModel errorTrendingMoviesModelFromJson(String str) =>
    ErrorTrendingMoviesModel.fromJson(json.decode(str));

String errorTrendingMoviesModelToJson(ErrorTrendingMoviesModel data) =>
    json.encode(data.toJson());

class ErrorTrendingMoviesModel {
  ErrorTrendingMoviesModel({
    required this.statusCode,
    required this.statusMessage,
    required this.success,
  });

  int statusCode;
  String statusMessage;
  bool success;

  factory ErrorTrendingMoviesModel.fromJson(Map<String, dynamic> json) =>
      ErrorTrendingMoviesModel(
        statusCode: json["status_code"],
        statusMessage: json["status_message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status_message": statusMessage,
        "success": success,
      };
}
