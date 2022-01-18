import 'package:elm_application/data/api_models/trending_movies_model.dart';
import 'package:elm_application/data/singletones/api.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

enum Status { hasData, hasError, loading }

class HomePageController extends GetxController {
  HomePageController();

  int pages = 1;
  RxBool showLoader = false.obs;
  var moviesList = [].obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    getTrendingMovies2021();
    bottomPageReached();
    super.onInit();
  }

  Future getTrendingMovies2021() async {
    showLoader = RxBool(true);
    return ApiClient.apiClient.getTrendingMovies(pages).then((value) {
      moviesList.addAll(value.results!);

      showLoader = RxBool(false);
    });
  }

  void incrementPage() {
    showLoader = RxBool(true);
    pages++;
    getTrendingMovies2021();
    // update();
  }

  void bottomPageReached() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        debugPrint("___max reached");
        incrementPage();
      }
    });
  }
}
