import 'package:elm_application/app/imports.dart';

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
          child: Image.network(
            imageName,
            fit: BoxFit.cover,
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
