import 'package:http/http.dart' as http;
import '../models/subcategory-model.dart';

class Subcategories {
  String url = "http://192.168.31.58:8000/api/";
  Future<List<Subcategory>> fetchSubcategories(cid) async {
    final response = await http.get(url+ "subcategories?cid=" + cid.toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return subcategoryFromJson(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load category');
    }
  }
}