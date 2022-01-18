// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:elm_application/app/globals.dart';
import 'package:elm_application/data/api_models/trending_movies_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  ApiClient._();

  static final ApiClient apiClient = ApiClient._();
  static final http.Client _httpClient = http.Client();

  //Dev API
  static const String _DEV_URL = "https://api.themoviedb.org";

  //Prod API
  static const String _PROD_URL = "https://blabla-prod.com/";

  /// Actual Api that wll be used, regardless what server we point to(Dev or Prod).
  static const String BASE_URL = "$_DEV_URL";

  ///All our apis will use h=this header, if need to change will change inside method.
  static const Map<String, String> _header = {
    'Content-type': 'application/json',
    // 'token': mUserToken,
  };

  Future<TrendingMoviesModel> getTrendingMovies(int page) async {
    try {
      final response = await _httpClient.get(
        Uri.parse(
            "$BASE_URL/3/trending/movie/week?api_key=$mApiKey&page=$page"),
        headers: _header,
      );

      debugPrint("___getTrendingMovies " + response.body);
      final parsed = json.decode(response.body);
      TrendingMoviesModel trendingMoviesModel =
          TrendingMoviesModel.fromJson(parsed);

      // if (_checkIsSuccessResponse(trendingMoviesModel.results)) {
      //   return trendingMoviesModel;
      // } else {
      //   return Future.error("Failed response");
      // }
      return trendingMoviesModel;
    } on SocketException {
      return Future.error("______check your internet connection_____");
    } on http.ClientException {
      return Future.error("______check your internet connection_____");
    } catch (e) {
      return Future.error("______Server Error_______");
    }
  }

  ///check if this is successful response
  ///
  /// returns [True] if results are not null.
  bool _checkIsSuccessResponse(List<Result>? results) {
    return results != null;
  }
}
