import 'package:elm_application/app/resourses.dart';
import 'package:elm_application/data/api_models/movie_cast_model.dart';
import 'package:elm_application/data/singletones/api.dart';
import 'package:elm_application/views/details/details_page_controller.dart';
import 'package:elm_application/views/reusable_widgets/cast_card.dart';
import 'package:elm_application/views/reusable_widgets/gredient_image.dart';
import 'package:elm_application/views/reusable_widgets/responsive.dart';
import 'package:elm_application/views/reusable_widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class DetailsPage extends StatelessWidget {
  final String id;

  const DetailsPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: getMediaHeight(context),
        width: getMediaWidth(context),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: GetX<DetailsPageController>(
                    init: DetailsPageController(id),
                    builder: (DetailsPageController controller) {
                      if (controller.movieDertails.value.id != null) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // --- GradientImg --- //
                            _HeaderMoviePoster(
                              title: controller.movieDertails.value.title!,
                              posterPath:
                                  controller.movieDertails.value.posterPath!,
                            ),
                            // --- Rating --- //
                            _MovieRatingBar(
                              voteAverage:
                                  controller.movieDertails.value.voteAverage!,
                            ),
                            // --- Overview --- //
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                appLocalizations(context).overview,
                                style: getTextTheme(context).caption,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                controller.movieDertails.value.overview!,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            const MHeight(30),
                            // --- Budget - Duration - ReleaseData --- //
                            BudgetDurationRealeaseDate(
                              budget: controller.movieDertails.value.budget!,
                              duration: controller.movieDertails.value.runtime!,
                              releaseDate:
                                  controller.movieDertails.value.releaseDate!,
                            ),
                            MHeight(get20Size(context)),
                            // --- Genres --- //
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                appLocalizations(context).genres,
                                style:
                                    getTextTheme(context).bodyText2?.copyWith(
                                          color: Colors.grey,
                                        ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                direction: Axis.horizontal,
                                spacing: 15,
                                children: List.generate(
                                  controller.movieDertails.value.genres!.length,
                                  (index) {
                                    return Genre(
                                      title:
                                          "${controller.movieDertails.value.genres![index].name}",
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                            MHeight(get20Size(context)),
                            // --- Cast --- //
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                appLocalizations(context).cast,
                                style:
                                    getTextTheme(context).bodyText2?.copyWith(
                                          color: Colors.grey,
                                        ),
                              ),
                            ),
                            MovieCast(id: controller.id),
                            MHeight(get20Size(context)),
                          ],
                        );
                      } else {
                        return SizedBox(
                          height: getMediaHeight(context),
                          child: Center(
                            child: MyLoadingWidget(),
                          ),
                        );
                      }
                      //
                    }),
              ),
              // --- Back Arrow --- //
              const SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: BackArrowIcon(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieCast extends StatelessWidget {
  final String id;

  const MovieCast({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getMediaWidth(context),
      height: get160Size(context) + 5,
      child: FutureBuilder<MovieCastModel>(
          future: ApiClient.apiClient.getMovieCast(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.cast!.length,
                itemBuilder: (context, index) {
                  return AspectRatio(
                    aspectRatio: 0.8,
                    child: CastCard(
                      imagePath: ResourseManager.getFullNetworkImagePath(
                          snapshot.data!.cast![index].profilePath!),
                      actorName: snapshot.data!.cast![index].name!,
                      bio: "${snapshot.data!.cast![index].character}",
                    ),
                  );
                },
              );
            } else {
              return MyLoadingWidget();
            }
          }),
    );
  }
}

class BudgetDurationRealeaseDate extends StatelessWidget {
  final dynamic budget, duration, releaseDate;
  static final _currency = intl.NumberFormat("#,##0", "en_US");

  const BudgetDurationRealeaseDate({
    Key? key,
    required this.budget,
    required this.duration,
    required this.releaseDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: get50Size(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _TitleAndValue(
              title: appLocalizations(context).budget,
              value: "${_currency.format(budget)}\$",
            ),
            _TitleAndValue(
              title: appLocalizations(context).duration,
              value: "$duration min",
            ),
            _TitleAndValue(
              title: appLocalizations(context).releaseDate,
              value: intl.DateFormat('yyyy-MM-dd').format(releaseDate),
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleAndValue extends StatelessWidget {
  final String title, value;

  const _TitleAndValue({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title.toUpperCase(),
          style: getTextTheme(context).bodyText2?.copyWith(
                color: Colors.grey,
              ),
        ),
        //
        Text(
          value,
          style: getTextTheme(context).button?.copyWith(
                color: Colors.amber[700],
              ),
        ),
      ],
    );
  }
}

class Genre extends StatelessWidget {
  final String title;

  const Genre({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: containerColorRadiusBorder(
        getTheme(context).scaffoldBackgroundColor,
        12,
        getTextTheme(context).bodyText1!.color!,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title),
      ),
    );
  }
}

class _HeaderMoviePoster extends StatelessWidget {
  final String posterPath, title;

  const _HeaderMoviePoster({
    Key? key,
    required this.title,
    required this.posterPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomRight,
      children: [
        SizedBox(
          height: get200Size(context) + 50,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              GredientImage(
                imageName: ResourseManager.getFullNetworkImagePath(
                  posterPath,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  maxLines: 4,
                  style: getTextTheme(context).headline6,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -30,
          right: 16,
          child: Padding(
            padding: mHor16Vert8,
            child: ClipOval(
              child: Material(
                color: Colors.amber,
                child: InkWell(
                  onTap: () {
                    //show movie trailer
                  },
                  child: const SizedBox(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.play_arrow,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MovieRatingBar extends StatelessWidget {
  final double voteAverage;

  const _MovieRatingBar({
    Key? key,
    required this.voteAverage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      // width: get120Size(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(voteAverage.toString()),
          const MWidth(10),
          Container(
            child: RatingBar.builder(
              initialRating: voteAverage / 2,
              itemSize: 15,
              minRating: 0,
              maxRating: 5,
              ignoreGestures: true,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {},
            ),
          ),
        ],
      ),
    );
  }
}
