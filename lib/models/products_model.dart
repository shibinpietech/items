class Products {
  List<Product> products;
  int total;
  int skip;
  int limit;

  Products({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      products: (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e))
          .toList(),
      total: json['total'] ?? 0,
      skip: json['skip'] ?? 0,
      limit: json['limit'] ?? 0,
    );
  }
}

class Product {
  int id;
  String title;
  String description;
  dynamic price;
  dynamic discountPercentage;
  dynamic rating;
  dynamic stock;
  String brand;
  String category;
  String thumbnail;
  List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      discountPercentage: json['discountPercentage'] ?? 0.0,
      rating: json['rating'] ?? 0.0,
      stock: json['stock'] ?? 0,
      brand: json['brand'] ?? '',
      category: json['category'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      images:
          (json['images'] as List<dynamic>).map((e) => e.toString()).toList(),
    );
  }
}
