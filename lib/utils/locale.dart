
import 'package:ecommerce/utils/converter.dart';
import 'package:intl/intl.dart';



class LocaleUtils {
  static String getCurrencyFormat(num number) {
    String cultureInfo = 'en-IN';
    cultureInfo = cultureInfo.isEmpty ? 'en-IN' : cultureInfo;
    cultureInfo = cultureInfo.replaceAll("-", "_");
    var formatter = NumberFormat.simpleCurrency(locale: cultureInfo, decimalDigits: 2);
    return formatter.format(number);
  }

  static String currencyFormat(String? str) {
    if (str == null) return "0";
    var number = Converter.getDouble(str);
    return getCurrencyFormat(number);
  }
}
