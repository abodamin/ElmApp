// ignore_for_file: constant_identifier_names

///
///assets names and paths, similar to Android R file.
///

class ResourseManager {
  static const String _ASSETS = "assets/";
  static const String _IMAGES = "images/";

  static const String _ASSETS_IMAGES = _ASSETS + _IMAGES;

  //Asset images path
  static const String ic_person = _ASSETS_IMAGES + "ic_person.png";

  //Network images path
  static const String _image_base_url_highQ =
      "https://image.tmdb.org/t/p/original";
  static const String _image_base_url_lowQ = "https://image.tmdb.org/t/p/w185";

  ///returns the full path for this image from assets
  static String getAssetImagePath(String assetName) {
    return "$_ASSETS_IMAGES$assetName";
  }

  ///returns the path for this image from network
  ///
  ///[highQuality] optional parameter to request high resolution img.
  static String getNetworkImagePath(String subPath,
      {bool highQuality = false}) {
    return highQuality
        ? _image_base_url_highQ + subPath
        : _image_base_url_lowQ + subPath;
  }
}
