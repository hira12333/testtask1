import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/constants/app_sizes.dart';
import 'package:test_task/constants/color.dart';
import 'package:test_task/constants/style.dart';
import 'package:test_task/imagePaths/assets.dart';
import 'package:test_task/view/screens/bottom_nav_bar/bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Example: Navigating to the home screen after a delay of 2 seconds
    Timer(
      Duration(seconds: 4),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavBar(),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: const Image(
              image: AssetImage(Assets.imagesSplash),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(gradient: myGradient),
          ),
          Padding(
            padding: AppSizes.DEFAULT_HORIZONTAL,
            child: Center(
              child: Container(
                height: Get.height * 0.85,
                width: Get.width,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'My Store',
                      style: TextStyle(fontFamily: 'playfair', fontSize: 50),
                    ),
                    Column(
                      children: [
                        Text(
                          'Valkommen\n',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 14,
                              color: kTertiaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Hos ass kan du baka tid has nastan alla Sveriges salonger och motagningar. Baka frisor, massage, skonhetsbehandingar, friskvard och mycket mer.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            height: 1.5,
                            fontFamily: 'poppins',
                            color: kTertiaryColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
