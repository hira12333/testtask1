class ProductsApi {
  String title, url;
  int id;
  double rating;
  double price;
  String brand;
  String category;
  List<dynamic> images;
  String description;
  double Stock;

  ProductsApi({
    required this.title,
    required this.url,
    required this.id,
    required this.price,
    required this.rating,
    required this.category,
    required this.brand,
    required this.images,
    required this.description,
    required this.Stock,
  });
}
