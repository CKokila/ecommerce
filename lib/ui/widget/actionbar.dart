import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../const/color.dart';

class ActionBar extends StatelessWidget {
  final void Function()? onLeadPressed;
  final Widget? action;
  final Widget? title;
  final double? elevation;

  const ActionBar({
    super.key,
    this.onLeadPressed,
    this.title,
    this.action,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return AppBar(
      centerTitle: false,
      elevation: elevation ?? 0,
      backgroundColor: Colors.white,
      leadingWidth: 46,
      leading: IconButton(
        splashRadius: 20,
        icon: Icon(CupertinoIcons.arrow_left, color:kTextColor),
        color: theme.primaryColor,
        onPressed: onLeadPressed ??
            () {
              context.router.back();
            },
      ),
      titleSpacing: 0,
      title: title,
      actions: [action != null ? Padding(padding: const EdgeInsets.only(right: 16.0), child: action!) : Container()],
    );
  }
}
