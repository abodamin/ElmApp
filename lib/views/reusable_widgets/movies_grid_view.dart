import 'package:elm_application/app/imports.dart';
import 'package:elm_application/app/resourses.dart';
import 'package:elm_application/views/home/home_page.dart';
import 'package:elm_application/views/home/home_page_controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class MoviesGridView extends StatelessWidget {
  final List<dynamic> listOfMovies;

  MoviesGridView({
    Key? key,
    required this.listOfMovies,
  }) : super(key: key);

  final HomePageController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getMediaHeight(context),
      child: Directionality(
        textDirection: TextDirection.ltr, //because all movie names in English
        child: Builder(builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 9,
                fit: FlexFit.tight,
                child: GridView.builder(
                  shrinkWrap: true,
                  controller: _controller.scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.45,
                  ),
                  itemCount: listOfMovies.length,
                  itemBuilder: (context, index) {
                    if (listOfMovies.isEmpty) {
                      return Center(
                        child: Text(
                          "No Elements to show",
                          style: getTextTheme(context).headline6,
                        ),
                      );
                    } else {
                      return MovieCardItem(
                        title: listOfMovies[index].title!,
                        imagePath: listOfMovies[index].posterPath!,
                        voteAverage: listOfMovies[index].voteAverage!,
                      );
                    }
                  },
                ),
              ),
              Visibility(
                visible: _controller.showLoader.value,
                child: MyLoadingWidget(),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class MovieCardItem extends StatelessWidget {
  final String title, imagePath;
  final double voteAverage;

  const MovieCardItem({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.voteAverage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(4),
        height: get200Size(context) + get50Size(context),
        width: getMediaWidth(context),
        child: InkWell(
          onTap: () {},
          child: SizedBox(
            height: get100Size(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  height: get200Size(context),
                  child: Image.network(
                    ResourseManager.getNetworkImagePath(
                      imagePath,
                    ),
                    fit: BoxFit.fill,
                    width: get120Size(context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: get120Size(context),
                    child: Text(
                      title,
                      maxLines: 2,
                    ),
                  ),
                ),
                const Spacer(),
                //
                Container(
                  padding: const EdgeInsets.all(8.0),
                  // width: get120Size(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("$voteAverage"),
                      RatingBar.builder(
                        initialRating: voteAverage,
                        itemSize: 15,
                        minRating: 0,
                        maxRating: 5,
                        ignoreGestures: true,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 0.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
