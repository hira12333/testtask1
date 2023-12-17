import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:test_task/constants/app_sizes.dart';
import 'package:test_task/constants/color.dart';
import 'package:test_task/constants/style.dart';
import 'package:test_task/controller/favourites_provider.dart';
import 'package:test_task/imagePaths/assets.dart';
import 'package:test_task/view/reusable_widgets/my_ratings.dart';
import 'package:test_task/view/reusable_widgets/simple_app_bar.dart';
import 'package:test_task/view/screens/products.dart';
import 'package:http/http.dart' as http;

class ProductDetails extends StatefulWidget {
  final int id;

  ProductDetails({required this.id});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

// ... (Previous code)

class _ProductDetailsState extends State<ProductDetails> {
  Map<String, dynamic>? productData;
  List<Map<String, dynamic>> favoriteProducts = [];
  bool isFavorite = false;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('https://dummyjson.com/products/${widget.id}'));

    if (response.statusCode == 200) {
      setState(() {
        productData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load product data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(
          context: context, title: 'Product Details', hasIcon: true),
      body: productData == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: productData!['thumbnail'],
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                    width: Get.width,
                    height: 209,
                  ),
                  Padding(
                    padding: AppSizes.DEFAULT_PADDING,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Product Details',
                          style: styles(18, FontWeight.w900, kBlackColor),
                        ),
                        IconButton(
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: isFavorite ? Colors.red : null,
                          ),
                          onPressed: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                            Provider.of<FavoritesProvider>(context,
                                    listen: false)
                                .toggleFavorite(productData!);
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: AppSizes.DEFAULT_HORIZONTAL,
                    child: Column(
                      children: [
                        productDetailsTile('Name: ${productData!['title']}'),
                        productDetailsTile('Price: \$${productData!['price']}'),
                        productDetailsTile('Rating: ${productData!['rating']}'),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                'Rating: ${productData!['rating']}',
                                style: styles(14, FontWeight.w900, kBlackColor),
                              ),
                            ),
                            StarRating(rating: productData!['rating']),
                          ],
                        ),
                        productDetailsTile(
                            'Category: ${productData!['category']}'),
                        productDetailsTile('Brand: ${productData!['brand']}'),
                        productDetailsTile('Stock: ${productData!['stock']}'),
                        SizedBox(
                          width: Get.width,
                          child: productDetailsTile(
                              'Description: \n${productData!['description']}'),
                        ),
                        productDetailsTile('Product Gallery:'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: AppSizes.DEFAULT_PADDING,
                    child: SizedBox(
                      height: 500,
                      child: MasonryGridView.builder(
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 10,
                        itemCount: productData!['images'].length,
                        itemBuilder: (context, index) {
                          return CachedNetworkImage(
                            imageUrl: productData!['images'][index],
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          );
                        },
                        gridDelegate:
                            SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget productDetailsTile(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              maxLines: 4,
              title,
              style: styles(14, FontWeight.w900, kBlackColor),
            ),
          ),
        ],
      ),
    );
  }
}
