import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const mHor16Vert8 = EdgeInsets.symmetric(horizontal: 16, vertical: 8);
const mHor8Vert8 = EdgeInsets.symmetric(horizontal: 8, vertical: 8);

AppLocalizations appLocalizations(BuildContext context) {
  return AppLocalizations.of(context);
}

ThemeData getTheme(context) {
  return Theme.of(context);
}

TextTheme getTextTheme(context) {
  return Theme.of(context).textTheme;
}

double getMediaHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double getMediaWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double get200Size(BuildContext context) {
  return getMediaHeight(context) / 4.48;
}

double get190Size(BuildContext context) {
  return getMediaHeight(context) / 4.7;
}

double get160Size(BuildContext context) {
  return getMediaHeight(context) / 5.6;
}

double get140Size(BuildContext context) {
  return getMediaHeight(context) / 6.4;
}

double get120Size(BuildContext context) {
  return getMediaHeight(context) / 7.5;
}

double get100Size(BuildContext context) {
  return getMediaHeight(context) / 9;
}

double get80Size(BuildContext context) {
  return getMediaHeight(context) / 11.2;
}

double get60Size(BuildContext context) {
  return getMediaHeight(context) / 15;
}

double get50Size(BuildContext context) {
  return getMediaHeight(context) / 18;
}

double get40Size(BuildContext context) {
  return getMediaHeight(context) / 22.2;
}

double get30Size(BuildContext context) {
  return getMediaHeight(context) / 31;
}

double get20Size(BuildContext context) {
  return getMediaHeight(context) / 45;
}

double get18Size(BuildContext context) {
  return getMediaHeight(context) / 50;
}

double get16Size(BuildContext context) {
  return getMediaHeight(context) / 55;
}

double get14Size(BuildContext context) {
  return getMediaHeight(context) / 65;
}

double get12Size(BuildContext context) {
  return getMediaHeight(context) / 75;
}

double get10Size(BuildContext context) {
  return getMediaHeight(context) / 94;
}

double get8Size(BuildContext context) {
  return getMediaHeight(context) / 120;
}

double get6Size(BuildContext context) {
  return getMediaHeight(context) / 160;
}

double get4Size(BuildContext context) {
  return getMediaHeight(context) / 240;
}
