import 'package:ecommerce/const/color.dart';
import 'package:ecommerce/routing/app_router.dart';
import 'package:ecommerce/ui/cart/bloc/cart_bloc.dart';
import 'package:ecommerce/ui/home/bloc/home_bloc.dart';
import 'package:ecommerce/ui/login/bloc/login_bloc.dart';
import 'package:ecommerce/ui/product_detail/bloc/product_bloc.dart';
import 'package:ecommerce/ui/product_listing/bloc/product_listing_bloc.dart';
import 'package:ecommerce/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/prefs/current_user.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CurrentUser.getInstance();
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: kPrimaryLight,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => ProductListingBloc()),
        BlocProvider(create: (context) => ProductBloc()),
        BlocProvider(create: (context) => CartBloc()),
      ],
      child: MaterialApp.router(
        title: 'Ecommerce',
        routerConfig: appRouter.config(),
        themeMode: ThemeMode.light,
        theme: MyTheme.lightTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
