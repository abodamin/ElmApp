import 'package:elm_application/data/api_models/movie_details_model.dart';
import 'package:elm_application/data/singletones/api.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class DetailsPageController extends GetxController {
  static const String movieIdKey = "movieIdKey";
  String id;

  DetailsPageController(this.id);

  Rx<MovieDertailsModel> movieDertails = MovieDertailsModel().obs;
  dynamic argumentData = Get.arguments;

  @override
  onInit() {
    getMovieDetails(id);
    super.onInit();
  }

  Future getMovieDetails(String id) async {
    return ApiClient.apiClient.getMovieDetails(id).then((value) {
      debugPrint("___getting value of >>> $value");
      movieDertails.value = value;
    });
  }
}
