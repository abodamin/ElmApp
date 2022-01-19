// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:elm_application/app/globals.dart';
import 'package:elm_application/data/api_models/movie_cast_model.dart';
import 'package:elm_application/data/api_models/movie_details_model.dart';
import 'package:elm_application/data/api_models/trending_movies_model.dart';
import 'package:elm_application/data/singletones/external_files_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
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
  /// we change this to Prod for production enviroment.
  static const String BASE_URL = "$_DEV_URL";

  ///All our apis will use h=this header, if need to change will change inside method.
  static const Map<String, String> _header = {
    'Content-type': 'application/json',
    // 'token': mUserToken,
  };

  //Dependency Injection for filesManager
  final ExternalFilesManager filesManager = Get.put(ExternalFilesManager());

  Future<TrendingMoviesModel> getTrendingMovies(int page) async {
    try {
      final response = await _httpClient.get(
        Uri.parse(
            "$BASE_URL/3/trending/movie/week?api_key=$mApiKey&page=$page"),
        headers: _header,
      );

      debugPrint("___getTrendingMovies " + response.body);

      await filesManager.storeHomePageMovies(response.body);

      final parsed = json.decode(response.body);
      return TrendingMoviesModel.fromJson(parsed);
    } on SocketException {
      var oldData = await filesManager.retrieveHomePageMovies();
      final parsed = json.decode(oldData);
      return TrendingMoviesModel.fromJson(parsed);
    } on http.ClientException {
      return Future.error("______check your internet connection_____");
    } catch (e) {
      return Future.error("______Other Error >>$e");
    }
  }

  Future<MovieDertailsModel> getMovieDetails(String id) async {
    try {
      final response = await _httpClient.get(
        Uri.parse("$BASE_URL/3/movie/$id?api_key=$mApiKey&language=en-US"),
        headers: _header,
      );
      debugPrint("___getMovieDetails " + response.body);

      filesManager.storeMovieDetails(response.body, id);

      final parsed = json.decode(response.body);
      return MovieDertailsModel.fromJson(parsed);
    } on SocketException {
      var oldData = await filesManager.retrieveMovieDetails(id);
      final parsed = json.decode(oldData);
      return MovieDertailsModel.fromJson(parsed);
      // return Future.error("______check your internet connection_____");
    } on http.ClientException {
      return Future.error("______check your internet connection_____");
    } catch (e) {
      return Future.error("______Other Error >>$e");
    }
  }

  Future<MovieCastModel> getMovieCast(String id) async {
    try {
      final response = await _httpClient.get(
        Uri.parse("$BASE_URL/3/movie/$id/casts?api_key=$mApiKey"),
        headers: _header,
      );

      debugPrint("___getMovieCast " + response.body);
      await filesManager.storeCastDetails(response.body, id);

      final parsed = json.decode(response.body);
      return MovieCastModel.fromJson(parsed);
    } on SocketException {
      var oldData = await filesManager.retrieveCastDetails(id);
      final parsed = json.decode(oldData);
      return MovieCastModel.fromJson(parsed);
    } on http.ClientException {
      return Future.error("______check your internet connection_____");
    } catch (e) {
      return Future.error("______Other Error >>$e");
    }
  }
}
