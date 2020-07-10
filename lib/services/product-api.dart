import 'dart:convert';
import 'package:martkh/models/productlist.dart';
import 'package:http/http.dart' as http;
import 'package:martkh/models/products.dart';

// Future<List<Product>> fetchProducts() async {
//   // String url = "http://10.0.2.2:8000/api/products";
//   String url = "http://192.168.31.58:8000/api/products";
//   // final response = await client.get(Uri.http("localhost:8000","/api/products"));
//   final response = await http.get(url);
//   // return productFromJson(response.body);
//     // return productFromJson(json.decode(response.body));
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return productFromJson(response.body);
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load product');
//   }
// }

// Future<ListProduct> fetchProducts(int page) async {
//   // String url = "http://10.0.2.2:8000/api/products";
//   String url = "http://192.168.31.58:8000/api/products?page=" + page.toString();
//   // final response = await client.get(Uri.http("localhost:8000","/api/products"));
//   final response = await http.get(url);
//   // return productFromJson(response.body);
//     // return productFromJson(json.decode(response.body));
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return productFromJson(response.body);
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load product');
//   }
// }

class Products {
  static const url = "http://192.168.31.58:8000/api/";

  static Future<ProductList> fetchProducts(int page) async {
    http.Response response =
        await http.get(url + "productsWithPage?page=" + page.toString());
    final Map productsMap = JsonCodec().decode(response.body);
    // print(productsMap);
    ProductList products = ProductList.fromMap(productsMap);
    // print(products);
    if (products == null) {
      throw new Exception("An error occurred : [ Status Code = ]");
    }
    return products;
  }

  static Future<List<Product>> fetchProductList() async {
    final response = await http.get(url + "products");
    // print(response.body);
    // final products = json.decode(response.body);
    // print(product[0].name);
    // print(product[0]);
    if (response.statusCode == 200) {
      var product = productFromMap(response.body);
      return product;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load product');
    }
  }

  static Future<ProductList> searchProduct(String keyword, int page) async {
    http.Response response = await http.get(
        url + "searchProduct?keyword=" + keyword + "&?page=" + page.toString());
    if (response.body.isNotEmpty) {
      final Map productsMap = JsonCodec().decode(response.body);
      // print(productsMap);
      ProductList products = ProductList.fromMap(productsMap);
      // print(products);
      if (products == null) {
        throw new Exception("An error occurred : [ Status Code = ]");
      }
      return products;
    }
    // else{
    //   print("No input keyword");
    // }
  }

  static Future<ProductList> fetchProductSubcategory(int sid, int page) async {
    http.Response response = await http.get(url +
        "productSubcategory?sid=" +
        sid.toString() +
        "&page=" +
        page.toString());
    final Map productsMap = JsonCodec().decode(response.body);
    // print(productsMap);
    ProductList products = ProductList.fromMap(productsMap);
    // print(products);
    if (products == null) {
      throw new Exception("An error occurred : [ Status Code = ]");
    }
    return products;
  }

  // ProductList parseProducts(String responseBody) {
  //   final Map productsMap = JsonCodec().decode(responseBody);
  //   print(productsMap);
  //   ProductList products = ProductList.fromMap(productsMap);
  //   print(products);
  //   if (products == null) {
  //     throw new Exception("An error occurred : [ Status Code = ]");
  //   }
  //   return products;
  // }

  showProduct(pid) async {
    // String url = "http://10.0.2.2:8000/api/products";
    String url = "http://192.168.31.58:8000/api/showProduct/?pid=" + pid;
    // final response = await client.get(Uri.http("localhost:8000","/api/products"));
    final response = await http.get(url);
    // return productFromJson(response.body);
    // return productFromJson(json.decode(response.body));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return productFromJson(response.body)
      return response;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load product');
    }
  }
}

// Future<List<Product>> fetchProducts() async {
//   // String url = "http://192.168.65.1/martkh/products.php";
//   String url = "http://10.0.2.2:8000/api/products";
//   // final response = await client.get(Uri.http("localhost:8000","/api/products"));
//   final response = await http.get(url);
//   if (response.statusCode == 200) {
//     var jsonData = json.decode(response.body);
//     List<Product> products = [];
//     for (var p in jsonData){
//       Product product = Product(id: p["id"],image: p["image"],code: p["code"],name: p["name"],description: p["description"],price: p["price"],size: p["size"],brand: p["brand"],country: p["country"],subcategoryId: p["subcategoryId"],view: p["view"], createdAt: p["createdAt"],updatedAt: p["updatedAt"]);
//       products.add(product);
//     }
//     print(products.length);
//     return products;
//     // return productFromJson(response.body);
//   } else {
//     throw Exception('Failed to load album');
//   }
// }
