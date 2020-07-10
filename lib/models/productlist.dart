import 'package:martkh/models/products.dart';

class ProductList {
  ProductList({
    this.page,
    this.totalResults,
    this.totalPages,
    this.products,
  });
  final int page;
  final int totalResults;
  final int totalPages;
  final List<Product> products;
  ProductList.fromMap(Map<String, dynamic> value)
      : page = value['current_page'],
        totalResults = value['total'],
        totalPages = value['last_page'],
        products = List<Product>.from(
            value['data'].map((products) => Product.fromJson(products)));
}

