import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/locale.dart';

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
Widget textWithCurrency({required String text, required TextStyle? style}) {
  return Text(LocaleUtils.currencyFormat(text), style:style);
}

String moneyCode = '\$';
