import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ads-model.dart';

class Advertisement {
  String url = "http://192.168.31.58:8000/api/";
  Future<List<Ads>> fetchAds() async {
    final response = await http.get(url+ "ads");
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return adsFromJson(response.body);
      return (json.decode(response.body) as List).map((data) => Ads.fromJson(data)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load advertisement');
    }
  }
}