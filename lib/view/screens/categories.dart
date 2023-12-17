import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/constants/app_sizes.dart';
import 'package:test_task/constants/color.dart';
import 'package:test_task/constants/style.dart';
import 'package:test_task/imagePaths/assets.dart';
import 'package:test_task/view/reusable_widgets/simple_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:test_task/view/screens/category_filter_products.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late Future<List<String>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories();
  }

  Future<List<String>> fetchCategories() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products/categories'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      List<String> fetchedCategories =
          data.map((category) => category.toString()).toList();
      return fetchedCategories;
    } else {
      throw Exception('Failed to fetch categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          simpleAppBar(context: context, title: 'Categories', hasIcon: false),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: futureCategories,
              builder: (context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('No categories found.'),
                  );
                } else {
                  return Column(
                    children: [
                      myTextFeild(),
                      Expanded(
                        child: Padding(
                          padding: AppSizes.DEFAULT_PADDING,
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                            ),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    Get.to(() => CategoryFilterProducts(
                                        category: snapshot.data![index]));
                                  },
                                  child: GridItem(item: snapshot.data![index]));
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget myTextFeild() {
    return Padding(
      padding: AppSizes.DEFAULT_HORIZONTAL,
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          // filled: isFilled,
          // fillColor: filledColor ?? kTertiaryColor,
          hintText: 'Search',
          hintStyle: const TextStyle(
            fontFamily: 'poppins',
            fontSize: 12,
            color: kGrey7Color,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: kBlackColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: kSecondaryColor ?? kGrey9Color, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kSecondaryColor, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String item;

  const GridItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Container(
        height: 125,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Assets.imagesSplash), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item,
              style: mystyle(12, FontWeight.bold, kPrimaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
