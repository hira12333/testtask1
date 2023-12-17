import 'package:get/get.dart';
import 'package:test_task/view/screens/splash_screen.dart';

class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(
      name: AppLinks.splash,
      page: () => SplashScreen(),
    ),
  ];
}

class AppLinks {
  static const splash = '/splash_screen';
}
