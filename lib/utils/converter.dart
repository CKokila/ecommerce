import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'log.dart';


class Converter {
  static String convertToAgo(String dateTime) {
    if (dateTime.isNotEmpty) {
      var v = DateTime.parse(dateTime).toLocal();
      Duration diff = DateTime.now().difference(v);

      if (diff.inDays >= 1) {
        return '${diff.inDays}d';
      } else if (diff.inHours >= 1) {
        return '${diff.inHours}h';
      } else if (diff.inMinutes >= 1) {
        return '${diff.inMinutes}m';
      } else if (diff.inSeconds >= 1) {
        return '${diff.inSeconds}s';
      } else {
        return 'just now';
      }
    } else {
      return '-';
    }
  }
  static String time12Format(String time) {
    try {
      if (time.isNotEmpty) {
        DateTime d = DateFormat("HH:mm:ss").parse(time.toUpperCase());
        return DateFormat("hh:mm a").format(d).toString();
      } else {
        return "-";
      }
    } catch (e) {
      Log.d("Time cache $e");
      return '';
    }
  }
  static String localTime(String s) {
    try {
      var dateTime = DateTime.parse(s).toLocal();
      var formatter = DateFormat("dd MMM yyyy hh:mm a");
      var formatted = formatter.format(dateTime);
      return formatted.toString().toLowerCase();
    }  catch (e) {
      return "";
    }
  }

  static String dateTimeFormat(var s, format) {
    var dateTime;
    if (s.runtimeType != DateTime) {
      dateTime = DateTime.parse(s).toLocal();
    } else {
      dateTime = s;
    }
    var formatter = DateFormat(format);
    var formatted = formatter.format(dateTime);
    return formatted.toString();
  }

  static String orderDate(String? date,{bool? isTime}) {
    try {
      DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
      DateTime dateTime = dateFormat.parse(date!).toLocal();
      return dateTimeFormat(dateTime, "dd MMM yyyy ${isTime == false ? '':'hh:mm a'}");
    } catch (e) {
      Log.d("date convert catch $e");
      return '';
    }
  }

  static String amount(String? s, {bool? excludeSymbol = false}) {
    var a = getDouble(s);
    return amountFromDouble(a, excludeSymbol: excludeSymbol ?? false);
  }

  static amountStringFixed(String value, {bool excludeSymbol = false}) {
    var a = getDouble(value);
    var numDec = a % 1;
    int decimalDigits = numDec > 0 ? 2 : 0;
    NumberFormat formatCurrency;
    if (excludeSymbol) {
      formatCurrency = NumberFormat.currency(locale: 'en_IN', symbol: '', decimalDigits: decimalDigits);
    } else {
      formatCurrency = NumberFormat.currency(locale: 'en_IN', symbol: '\u{20B9}', decimalDigits: decimalDigits);
    }

    return formatCurrency.format(a);
  }


  static String amountFromDouble(dynamic s, {bool excludeSymbol = false}) {
    NumberFormat formatCurrency;
    if (excludeSymbol) {
      formatCurrency = NumberFormat.currency(locale: 'en_IN', symbol: '');
    } else {
      formatCurrency = NumberFormat.currency(locale: 'en_IN', symbol: '\u{20B9}');
    }

    try {
      return formatCurrency.format(s);
    } catch (e) {
      return '0.00';
    }
  }

  static String amountSplit(dynamic s, {bool excludeSymbol = false}) {
    NumberFormat formatCurrency;
    if (excludeSymbol) {
      formatCurrency = NumberFormat.currency(customPattern: '#,##,000',decimalDigits: 2);
    } else {
      formatCurrency = NumberFormat.currency(customPattern: '#,##,000',decimalDigits: 2);
    }

    try {
      return formatCurrency.format(s);
    } catch (e) {
      return '0.00';
    }
  }

  static double getDouble(String? str) {
    try {
      return double.parse(str ?? '0');
    } catch (e) {
      return 0;
    }
  }

  static num getNum(dynamic s){
    try {
      return num.parse(s ?? '0');
    } catch (e) {
      return 0;
    }
  }

  static int getInt(String? str) {
    try {
      return int.parse(str ?? '0');
    } catch (e) {
      return 0;
    }
  }

  static double round(double d) {
    try {
      return num.parse(d.toStringAsFixed(2)).toDouble();
    } catch (e) {
      return 0.00;
    }
  }

  static double stringFixed(double d) {
    try {
      return num.parse(d.toStringAsFixed(0)).toDouble();
    } catch (e) {
      return 0;
    }
  }


  static String split(String s, int index) {
    var splitValue = s.split('to');
    return splitValue[index];
  }

  static String getCurrencyFormat() {
    String? cultureInfo = "en-IN";
    cultureInfo = cultureInfo.replaceAll("-", "_");
    var formatter = NumberFormat.simpleCurrency(locale: cultureInfo, decimalDigits: 0);
    var v = formatter.format(1).substring(0, 1);
    return v.toString();
  }

  static int getPaise(String amount) {
    if (amount.contains('.')) {
      int a = Converter.getInt(amount.toString().split(".")[0]);
      int b = Converter.getInt(amount.toString().split(".")[1]);
      var v = a * 100;
      int totalAmount = v + b;
      return totalAmount;
    } else {
      int a = Converter.getInt(amount.toString().split(".")[0]);
      var v = a * 100;
      return v;
    }
  }


  static String deliveryDay(String? cutoff, String? noOfDays) {
    // In case if we received 0 or null in noOfDays, Set it as 1 (today delivery)
    try {
      int deliveryDate = getInt(noOfDays);
      if (deliveryDate == 0) deliveryDate = 1;

      // Format cutoff time
      DateTime now = DateTime.now();
      DateFormat formatter = DateFormat("hh:mm a");
      var temp = formatter.format(now);
      DateTime currentTime = formatter.parse(temp);
      var time = '';
      if (cutoff == null || cutoff.isEmpty) {
        deliveryDate = deliveryDate - 1;
      } else {
        try {
          DateTime cutoffTime = formatter.parse(cutoff.toUpperCase());
          if (currentTime.isBefore(cutoffTime)) {
            deliveryDate = deliveryDate - 1;
          }
        } catch (e) {}
      }

      if (deliveryDate == 0) {
        time = "Today";
      } else if (deliveryDate == 1) {
        time = "Tomorrow";
      } else {
        var day = now.add(Duration(days: deliveryDate));
        time = dateTimeFormat(day, "EEE dd,MMM");
      }
      return time;
    } catch (e) {
      Log.d("Catch delivery $e");
      return '';
    }
  }

  static String? untilTime(String? cutoff) {
    if (cutoff == null || cutoff.isEmpty) return null;
    // Format cutoff time
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat("hh:mm a");
    var temp = formatter.format(now);
    DateTime currentTime = formatter.parse(temp);
    DateTime cutoffTime;
    try {
      cutoffTime = formatter.parse(cutoff.toUpperCase());
    } catch (e) {
      return null;
    }

    Duration differenceTime = cutoffTime.difference(currentTime);
    int hours = differenceTime.inHours;
    int mins = differenceTime.inMinutes;
    if (mins > 0 && hours > 0) {
      mins = mins % (hours * 60);
    }
    String diff = '';
    if (hours > 0) {
      diff += "$hours hrs";
    }
    if (mins > 0) {
      if (diff.isNotEmpty) diff += ' ';
      diff += "$mins mins";
    }
    if (diff.isEmpty) return null;
    return diff;
  }

}

bool gstValidation(String gst) {
  RegExp validCharacters = RegExp("^[0-9]{2}[A-Z]{5}" "[0-9]{4}[A-Z]{1}[" "1-9A-Z]{1}Z[0-9A-Z]{1}");

  if (validCharacters.hasMatch(gst)) {
    return true;
  } else {
    return false;
  }
}

bool panValidation(String pan) {
  RegExp validCharacters = RegExp("[A-Z]{5}[0-9]{4}[A-Z]{1}");
  if (pan.length == 10) {
    if (validCharacters.hasMatch(pan)) {
      return true;
    } else {
      Log.d("Enter valid PAN no");
      return false;
    }
  } else {
    return false;
  }
}

class UpperCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}
String encrypt(username,password){
  var encrypted = base64.encode(utf8.encode('$username:$password'));
  return encrypted;
}