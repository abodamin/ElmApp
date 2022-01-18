import 'package:elm_application/app/imports.dart';
import 'package:elm_application/views/reusable_widgets/general_cached_image.dart';

class GredientImage extends StatelessWidget {
  final String imageName;

  const GredientImage({
    Key? key,
    required this.imageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        SizedBox(
          width: getMediaWidth(context),
          child: GeneralCachedImage(
            height: 1000.0,
            photoPath: imageName,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: getTheme(context).backgroundColor,
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.transparent,
                getTheme(context).scaffoldBackgroundColor,
              ],
              stops: const [0.0, 1.0],
            ),
          ),
        ),
      ],
    );
  }
}
