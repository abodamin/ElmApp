import 'package:elm_application/app/imports.dart';
import 'package:elm_application/views/reusable_widgets/avatar_photo.dart';

class CastCard extends StatelessWidget {
  final String imagePath, actorName, bio;

  const CastCard({
    Key? key,
    required this.imagePath,
    required this.actorName,
    required this.bio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: containerColorRadiusBorder(
            Colors.transparent,
            300,
            Colors.transparent,
          ),
          width: get80Size(context),
          height: get80Size(context),
          clipBehavior: Clip.antiAlias,
          child: AvatarPhoto(
            photoPath: "$imagePath",
            height: get20Size(context),
          ),
        ),
        Text(
          actorName,
          style: getTextTheme(context).button,
          textAlign: TextAlign.center,
        ),
        Text(
          bio,
          style: getTextTheme(context).caption,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
