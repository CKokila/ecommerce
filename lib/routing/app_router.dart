import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import '../data/prefs/current_user.dart';
import '../ui/home/home.dart';
import '../ui/home/mobile_bottom.dart';
import '../ui/login/login_page.dart';
import '../utils/log.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, path: '/login'),
        AutoRoute(page: MobileBottomRoute.page, path: '/', guards: [
          HomeGuard()
        ], children: [
          AutoRoute(page: HomeRoute.page, path: 'home'),
        ]),
      ];
}

class HomeGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    CurrentUser user = CurrentUser();
    if (user.getToken.isEmpty) {
      router.push(LoginRoute());
    } else {
      resolver.next(true);
    }
  }
}

class LoginGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    CurrentUser user = CurrentUser();
    if (user.getToken.isNotEmpty) {
      router.push(HomeRoute());
    } else {
      resolver.next(true);
    }
  }
}
