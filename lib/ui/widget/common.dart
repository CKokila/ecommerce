import 'package:ecommerce/const/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/locale.dart';
import 'package:lottie/lottie.dart';

Widget circularProgress(bool isLoading, BuildContext context) {
  ThemeData theme = Theme.of(context);
  return Align(
    alignment: Alignment.center,
    child: Visibility(
      visible: isLoading,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
      ),
    ),
  );
}

Widget textWithCurrency({required num? text, required TextStyle? style}) {
  return Text(LocaleUtils.currencyFormat(text.toString()), style: style);
}

String moneyCode = '\$';

Widget productEmpty({context, asset, message}) {
  var textTheme = Theme.of(context).textTheme;
  return Align(
    alignment: Alignment.center,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Icon(Icons.hourglass_empty, color: kPrimaryLight),
            // Lottie.asset(asset, width: 200, height: 200, repeat: false),
            const SizedBox(height: 20),
            Text(message ?? '',
                style: textTheme.titleSmall?.apply(fontWeightDelta: 12)),
          ],
        ),
      ],
    ),
  );
}
