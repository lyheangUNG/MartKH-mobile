// import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category-model.dart';

class Categories {
  String url = "http://192.168.31.58:8000/api/";
  Future<List<Category>> fetchCategories() async {
    final response = await http.get(url+ "categories");
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return categoryFromJson(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load category');
    }
  }
}
