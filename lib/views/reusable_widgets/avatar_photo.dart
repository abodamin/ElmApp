import 'package:cached_network_image/cached_network_image.dart';
import 'package:elm_application/app/imports.dart';
import 'package:elm_application/app/resourses.dart';

class AvatarPhoto extends StatelessWidget {
  final String photoPath;
  final double height;

  const AvatarPhoto({
    Key? key,
    required this.photoPath,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CachedNetworkImage(
        placeholder: (context, url) => Container(
          child: Image.asset(
            ResourseManager.ic_person,
            width: double.infinity,
            height: height,
            fit: BoxFit.cover,
          ),
          width: double.infinity,
          height: height,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Material(
          child: Image.asset(
            ResourseManager.ic_person,
            width: double.infinity,
            height: height,
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          clipBehavior: Clip.hardEdge,
        ),
        imageUrl: photoPath,
        width: double.infinity,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
