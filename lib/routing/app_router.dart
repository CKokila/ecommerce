import 'package:auto_route/auto_route.dart';
import 'package:ecommerce/utils/log.dart';
import 'package:flutter/material.dart';
import '../data/prefs/current_user.dart';
import '../ui/cart/cart_page.dart';
import '../ui/home/home.dart';
import '../ui/home/mobile_bottom.dart';
import '../ui/login/login_page.dart';
import '../ui/product_detail/product_detail.dart';
import '../ui/product_listing/product_listing.dart';
import '../ui/profile/profile_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, path: '/login'),
        AutoRoute(
            page: MobileBottomRoute.page,
            path: '/',
            initial: true,
            guards: [
              HomeGuard()
            ],
            children: [
              AutoRoute(page: HomeRoute.page, path: 'home'),
              AutoRoute(page: CartRoute.page, path: 'cart'),
              AutoRoute(page: ProfileRoute.page, path: 'profile'),
            ]),
        AutoRoute(
            page: ProductListingRoute.page,
            path: '/products/:category',
            guards: [HomeGuard()]),
        AutoRoute(
            page: ProductDetailRoute.page,
            path: '/product/:id',
            guards: [HomeGuard()]),
      ];
}

class HomeGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    CurrentUser user = CurrentUser();
    Log.d("Token ${user.getToken.isEmpty}");
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
