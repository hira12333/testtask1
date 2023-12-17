import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task/constants/color.dart';
import 'package:test_task/constants/style.dart';
import 'package:test_task/controller/favourites_provider.dart';
import 'package:test_task/view/reusable_widgets/my_ratings.dart';
import 'package:test_task/view/reusable_widgets/simple_app_bar.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: simpleAppBar(context: context, title: 'Favourites'),
      body: ListView.builder(
        itemCount: favoritesProvider.favoriteProducts.length,
        itemBuilder: (context, index) {
          // Build a widget for each favorite product
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                favoritesProvider.favoriteProducts[index]['thumbnail'],
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(favoritesProvider.favoriteProducts[index]['title']),
            subtitle: Column(children: [
              Row(
                children: [
                  Text(
                    "\$" +
                        favoritesProvider.favoriteProducts[index]['price']
                            .toString(),
                    style: mystyle(12, FontWeight.bold, kSecondaryColor),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    favoritesProvider.favoriteProducts[index]['rating']
                        .toString(),
                    style: mystyle(12, FontWeight.bold, kSecondaryColor),
                  ),
                  StarRating(
                      rating: favoritesProvider.favoriteProducts[index]
                          ['rating'])
                ],
              )
            ]),
            trailing: InkWell(
              onTap: () {
                favoritesProvider.removeFavorite(index);
              },
              child: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
            // Add more details as needed
          );
        },
      ),
    );
  }
}
