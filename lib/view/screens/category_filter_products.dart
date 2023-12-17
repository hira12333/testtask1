import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/constants/app_sizes.dart';
import 'package:test_task/constants/color.dart';
import 'package:test_task/constants/style.dart';
import 'package:test_task/controller/product_controller.dart';
import 'package:test_task/view/reusable_widgets/my_ratings.dart';
import 'package:test_task/view/reusable_widgets/simple_app_bar.dart';
import 'package:test_task/view/screens/products.dart';
import 'package:http/http.dart' as http;
import 'package:test_task/view/screens/products_details.dart';

class CategoryFilterProducts extends StatefulWidget {
  String category;
  CategoryFilterProducts({super.key, required this.category});

  @override
  State<CategoryFilterProducts> createState() => _CategoryFilterProductsState();
}

class _CategoryFilterProductsState extends State<CategoryFilterProducts> {
  @override
  List<ProductsApi> photosList = [];

  Future<List<ProductsApi>> getPhotos() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products?limit=100'));
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List<ProductsApi> photosList = (data['products'] as List)
          .map((product) => ProductsApi(
                title: product['title'],
                url: product['thumbnail'],
                id: product['id'],
                price: product['price'].toDouble(), // Parse as double
                rating: product['rating'].toDouble(), // Parse as double
                category: product['category'],
                brand: product['brand'],
                images: List<String>.from(product['images']),
                Stock: product['stock'].toDouble(),
                description: product['description'],
              ))
          .toList();
      return photosList;
    } else {
      throw Exception('Failed to load photos');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          simpleAppBar(context: context, title: widget.category, hasIcon: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          myTextFeild(),
          SizedBox(height: 10),
          Padding(
            padding: AppSizes.DEFAULT_HORIZONTAL,
            child: Text(
              '234 results found',
              style: styles(12, FontWeight.w300, kGrey5Color),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getPhotos(),
              builder: (context, AsyncSnapshot<List<ProductsApi>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    // Filter products by category
                    List<ProductsApi> categoryProducts = snapshot.data!
                        .where((product) => product.category == widget.category)
                        .toList();

                    return ListView.builder(
                      itemCount: categoryProducts.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.to(() =>
                                ProductDetails(id: categoryProducts[index].id));
                          },
                          child: productTile(
                            categoryProducts[index].title,
                            categoryProducts[index].url,
                            categoryProducts[index].brand,
                            categoryProducts[index].category,
                            categoryProducts[index].rating,
                            categoryProducts[index].price,
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
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

  Widget productTile(
    String title,
    String thumbnailurl,
    String brand,
    String category,
    double rating,
    double price,
  ) {
    return Padding(
      padding: AppSizes.DEFAULT_PADDING,
      child: Container(
        height: 286,
        decoration: rounded(Colors.transparent),
        child: Column(children: [
          Padding(
            padding: AppSizes.DEFAULT_HORIZONTAL,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(7),
                  bottomRight: Radius.circular(7)),
              child: Image(
                image: NetworkImage(thumbnailurl),
                height: 170,
                width: Get.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: AppSizes.DEFAULT_HORIZONTAL,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              title,
                              style: styles(16, FontWeight.w900, kBlackColor),
                            ),
                          ),
                          Text(
                            '\$$price',
                            style: styles(16, FontWeight.w900, kBlackColor),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: AppSizes.DEFAULT_HORIZONTAL,
                      child: Row(
                        children: [
                          Text(
                            '$rating ',
                            style: styles(10, FontWeight.w900, kBlackColor),
                          ),
                          StarRating(rating: rating),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: AppSizes.DEFAULT_HORIZONTAL,
                  child: Row(
                    children: [
                      Text(
                        'By $brand',
                        style: styles(10, FontWeight.w900, kBlackColor),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: AppSizes.DEFAULT_HORIZONTAL,
                  child: Row(
                    children: [
                      Text(
                        'In $category',
                        style: styles(10, FontWeight.w900, kBlackColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
