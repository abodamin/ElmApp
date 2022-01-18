import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ExternalFilesManager {
  const ExternalFilesManager();
  static const String _homePageMoviesFile = "homePageMoviesFile.txt";
  static const String _moviesDetailsFile = "moviesDetailsFile.txt";

  Future<void> storeHomePageMovies(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/$_homePageMoviesFile');
    await file.writeAsString(text);
  }

  Future<dynamic> retrieveHomePageMovies() async {
    String text = "";
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/$_homePageMoviesFile');
      text = await file.readAsString();
    } catch (e) {
      debugPrint("___Error in reading file _homePageMoviesFile error>> $e ");
    }
    return text;
  }

// ---- Movies Details File

  Future<void> storeMovieDetails(String text, String movieId) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/$_moviesDetailsFile-$movieId');
    await file.writeAsString(text);
  }

  Future<dynamic> retrieveMovieDetails(String movieId) async {
    String text = "";
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/$_moviesDetailsFile-$movieId');
      text = await file.readAsString();
    } catch (e) {
      debugPrint("___Error in reading file retrieveMovieDetails error>> $e ");
    }
    return text;
  }
}
