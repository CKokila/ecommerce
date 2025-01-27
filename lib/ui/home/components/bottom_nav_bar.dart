import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../const/color.dart';
import '../../../const/string.dart';


class BottomNavItem extends StatelessWidget {
  final int currentIndex;
  final void Function(int)? onTap;
  final int count;

  const BottomNavItem({super.key, required this.currentIndex, this.onTap, required this.count});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BottomNavigationBar(
      // elevation: 10,
      fixedColor: kPrimaryLight,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedIconTheme: const IconThemeData(color: kPrimaryLight),

      unselectedItemColor: const Color(0xff9A9A9A),
      items: [
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: SvgPicture.asset(
              currentIndex == 0 ? SvgPictures.homeFilled : SvgPictures.home,
              color:kPrimaryLight,
            ),
          ),
          label: "Home",
        ),
        // BottomNavigationBarItem(
        //   icon: Padding(
        //     padding: const EdgeInsets.only(bottom: 4.0),
        //     child: SvgPicture.asset(
        //       SvgPictures.category,
        //       color: color(context, currentIndex, 1),
        //     ),
        //   ),
        //   label: "Category",
        // ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8, top: 3),
                  child: SvgPicture.asset(
                    SvgPictures.bottomCart,
                    color: color(context, currentIndex, 2),
                  ),
                ),
                if (count != 0) ...[
                  Positioned(
                    top: 0,
                    right: 20,
                    child: Container(
                      width: 16,
                      height: 16,
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            count.toString(),
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  )
                ]
              ],
            ),
          ),
          label: "Cart",
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: SvgPicture.asset(currentIndex == 3 ? SvgPictures.profileFilled : SvgPictures.profile,
                color: color(context, currentIndex, 3)),
          ),
          label: "Profile",
        ),
      ],
    );
  }
}

Color color(BuildContext context, int currentIndex, int tabIndex) {
  ThemeData theme = Theme.of(context);
  return currentIndex == tabIndex ? kPrimaryLight : const Color(0xff9A9A9A);
}
