import 'package:ecommerce/const/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget loginBanner(BuildContext context) {
  var theme = Theme.of(context);
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return Container(
    height: height,
    color: theme.primaryColor,
    width: width * 0.60,
    child: Center(
      child: SizedBox(
          width: 500,
          height: 500,
          child: FittedBox(
              child: SvgPicture.asset(
            SvgPictures.loginBanner,
            width: 100,
            height: 100,
          ))),
    ),
  );
}
