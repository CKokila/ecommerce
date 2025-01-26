import 'package:flutter/material.dart';

class Dimens {
  static const double mobileWidth = 576.0;
  static const double horizontalPadding = 16.0;
  static const double verticalPadding = 12.0;
  static const double elementSpace = 16.0;
  static const double actionbarHeight = 48;
  static const double webHorPadding = 68;
  static const double webVerPadding = 28;
}

const double kBottomCartHeight = 64;
const double kMobileHeight = 730;

const double kContentHorPadding = 80.0;
BorderRadiusGeometry borderRadiusAll_5 = BorderRadius.circular(5);
BorderRadiusGeometry borderRadiusAll_15 = BorderRadius.circular(15);
BorderRadiusGeometry borderRadiusAll_20 = BorderRadius.circular(20);
BorderRadiusGeometry borderRadiusAll_10 = BorderRadius.circular(10);
BorderRadiusGeometry borderRadiusAll_8 = BorderRadius.circular(8);
BorderRadiusGeometry borderRadiusAll_30 = BorderRadius.circular(30);
BorderRadiusGeometry borderRadiusAll_50 = BorderRadius.circular(50);

BorderRadiusGeometry headerRadius =
const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10));


const EdgeInsets mobilePadding = EdgeInsets.symmetric(horizontal: 16,vertical: 12);

bool isMobile(BuildContext context) {
  double width = MediaQuery.sizeOf(context).width;
  return width < 601;
}
