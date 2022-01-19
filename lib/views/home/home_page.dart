import 'package:elm_application/app/imports.dart';
import 'package:elm_application/views/home/home_page_controller.dart';
import 'package:elm_application/views/reusable_widgets/movies_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  //DI
  final HomePageController _homePageController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLocalizations(context).appName,
        ),
      ),
      body: SizedBox.expand(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Header Title --- //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  appLocalizations(context).trendingMoviesTitle,
                  style: getTextTheme(context)
                      .headline6
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              // ---- List of Movies (GridView) ---- //
              Expanded(
                child: SizedBox(
                  height: getMediaHeight(context),
                  child: Obx(() {
                    return MoviesGridView(
                      // ignore: invalid_use_of_protected_member
                      listOfMovies: _homePageController.moviesList.value,
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
