import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:test_task/config/routes/routes.dart';
import 'package:test_task/config/theme/light_theme.dart';
import 'package:test_task/controller/favourites_provider.dart';
import 'package:test_task/view/screens/products_details.dart';
import 'package:test_task/view/screens/splash_screen.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritesProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'test_app',
      theme: lightTheme,
      themeMode: ThemeMode.light,
      // initialRoute: AppLinks.splash,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
      // getPages: AppRoutes.pages,
      home: SplashScreen(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
