import 'package:auto_route/auto_route.dart';
import 'package:ecommerce/routing/app_router.dart';
import 'package:flutter/material.dart';

import 'components/bottom_nav_bar.dart';

@RoutePage(name: "MobileBottomRoute")
class MobileBottom extends StatefulWidget {
  const MobileBottom({super.key});

  @override
  State<MobileBottom> createState() => _MobileBottomState();
}

class _MobileBottomState extends State<MobileBottom> {
  int currentIndex = 0;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: AutoTabsRouter(
      lazyLoad: false,
      homeIndex: 0,
      inheritNavigatorObservers: true,
      routes: const [
        HomeRoute(),
        // CategoryRoute(),
        CartRoute(),
        // Profile(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: SizedBox(
            height: 66,
            child: Theme(
              data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent),
              child: BottomNavItem(
                currentIndex: tabsRouter.activeIndex,
                count: count,
                onTap: (v) {
                  if (v == 2) {
                    context.router.pushNamed('cart');
                  } else {
                    setState(() {
                      tabsRouter.setActiveIndex(v);
                      currentIndex = v;
                    });
                  }
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),
            ),
          ),
        );
      },
    ));
  }
}
