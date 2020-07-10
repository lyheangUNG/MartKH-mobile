import 'package:http/http.dart' as http;
import 'package:martkh/models/franchise-model.dart';

Future<List<Franchise>> fetchFranchise() async {
  String url = "http://192.168.31.58:8000/api/franchise";
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return franchiseFromJson(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load wishlist');
  }
}