import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/color.dart';
import 'dimens.dart';

class MyTheme {
  static ThemeData get lightTheme => ThemeData(
      appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light),

      ///visual density added to standard cause button padding reducing on web
      visualDensity: VisualDensity.standard,
      iconTheme: const IconThemeData(color: Colors.black),
      splashColor: Colors.white,
      primaryColor: kPrimaryLight,
      dividerColor: kGrey,
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: kBorderColor)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: kPrimaryLight)),
        focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: kPrimaryLight)),
        border: UnderlineInputBorder(borderSide: BorderSide(color: kPrimaryLight)),
        errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: kPrimaryLight)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(kPrimaryLight),
            foregroundColor: const MaterialStatePropertyAll(Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      )),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))))),
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: kPrimaryLight, selectionHandleColor: Colors.transparent),
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xffffffff),
      colorScheme: const ColorScheme.light(primary: kPrimaryLight, secondary: kSecondaryLight),
      scrollbarTheme: const ScrollbarThemeData(radius: Radius.circular(5), thumbVisibility: MaterialStatePropertyAll(true)),
      textTheme: GoogleFonts.sourceSans3TextTheme(const TextTheme(
        bodyMedium: TextStyle(color: Color(0xff292D32)),
        titleMedium: TextStyle(color: Color(0xff292D32)),
        titleSmall: TextStyle(color: Color(0xff292D32)),
      )),
      dividerTheme: const DividerThemeData(color: Color(0xffC0C0C0), thickness: 0.4),
      buttonTheme: ButtonThemeData(
        buttonColor: kSecondaryLight,
        shape: RoundedRectangleBorder(borderRadius: borderRadiusAll_5),
      ));
}
