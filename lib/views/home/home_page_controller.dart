import 'package:elm_application/data/singletones/api.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

enum Status { hasData, hasError, loading }

class HomePageController extends GetxController {
  HomePageController();

  int page = 1;
  RxBool showLoader = false.obs;
  var moviesList = [].obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    requestTrendingMovies();
    bottomPageReached();
    super.onInit();
  }

  Future requestTrendingMovies() async {
    showLoader = RxBool(true);
    return ApiClient.apiClient.getTrendingMovies(page).then((value) {
      moviesList.addAll(value.results!);
      showLoader = RxBool(false);
    });
  }

  void incrementPage() {
    showLoader = RxBool(true);
    page++;
    requestTrendingMovies();
  }

  ///creates listener to update page when bottom is reached.
  void bottomPageReached() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        incrementPage();
      }
    });
  }
}
