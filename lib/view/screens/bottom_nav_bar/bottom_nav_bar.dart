import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:test_task/constants/color.dart';
import 'package:test_task/imagePaths/assets.dart';
import 'package:test_task/view/screens/categories.dart';
import 'package:test_task/view/screens/favourites.dart';
import 'package:test_task/view/screens/my_profile.dart';
import 'package:test_task/view/screens/products.dart';
import 'package:test_task/view/screens/splash_screen.dart';

class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Map<String, dynamic>> items = [
    {
      'image': Assets.imagesProducts,
      'label': 'Products',
    },
    {
      'image': Assets.imagesCategories,
      'label': 'Categories',
    },
    {
      'image': Assets.imagesFavourites,
      'label': 'Favourites',
    },
    {
      'image': Assets.imagesProfile,
      'label': 'Hira',
    },
  ];

  int currentIndex = 0;

  final List<Widget> screens = [
    Products(),
    Categories(),
    FavoritesScreen(),
    MyProfile(),
    // Categories(),
    // Favourites(),
    // Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: kSecondaryColor,
          boxShadow: [
            BoxShadow(
              color: kShadowColor.withOpacity(0.50),
              offset: const Offset(0, -2),
              blurRadius: 20,
            ),
          ],
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              log(currentIndex.toString());
            });
          },
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          selectedLabelStyle: const TextStyle(
            fontFamily: 'Inter-Regular',
            color: kSecondaryColor,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Inter-Regular',
            color: kSecondaryColor,
          ),
          selectedItemColor: kTertiaryColor,
          unselectedItemColor: kGrey8Color,
          items: List.generate(
            items.length,
            (index) {
              return BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage(
                    items[index]['image'],
                  ),
                  height: 25,
                ),
                label: items[index]['label'],
              );
            },
          ),
        ),
      ),
    );
  }
}
