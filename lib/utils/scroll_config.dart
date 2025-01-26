import 'package:flutter/material.dart';

///To remove color on listview in top
class MyBehaviour extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}