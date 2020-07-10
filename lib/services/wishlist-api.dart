import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:martkh/models/wishlist-model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Wishlist {
  // getData(apiUrl) async {
  //   var fullUrl = _url + apiUrl + await _getToken();
  //   // print(fullUrl);
  //   return await http.get(
  //     fullUrl,
  //     headers: _setHeaders()
  //   );
  // }

  checkLikeOrNot(pid) async {
    // String url = "http://10.0.2.2:8000/api/checkLikeOrNot?uid=" + await _getUserInfo() +"&pid=" + pid;
    String url = "http://192.168.31.58:8000/api/checkLikeOrNot?uid=" + await _getUserInfo() +"&pid=" + pid;
    // print(url);
    final response = await http.get(url);
    // print(response);
    return response;
  }

  addToWishList(pid) async {
    // String url = "http://10.0.2.2:8000/api/checkLikeOrNot?uid=" + await _getUserInfo() +"&pid=" + pid;
    String url = "http://192.168.31.58:8000/api/addToWishList?uid=" + await _getUserInfo() +"&pid=" + pid;
    final response = await http.get(url);
    // print(response);
    return response;
  }

  removeFromWishList(pid) async {
    String url = "http://192.168.31.58:8000/api/removeFromWishList?uid=" + await _getUserInfo() +"&pid=" + pid;
    final response = await http.get(url);
    // print(response);
    return response;
  }

}

_getUserInfo() async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    // print(userJson);
    if(userJson!=null){
      var user = json.decode(userJson);
      // print(user);
      // print(user['id']);
      return user['id'].toString();
    }
    return 0.toString();
}

Future<List<WishList>> fetchWishList() async {
  // String url = "http://192.168.65.1/martkh/products.php";
  // String url = "http://10.0.2.2:8000/api/wishlist?id=" + await _getUserInfo();
  String url = "http://192.168.31.58:8000/api/wishlist?id=" + await _getUserInfo();
  // final response = await client.get(Uri.http("localhost:8000","/api/products"));
  final response = await http.get(url);
  // print(url);
  if (response.statusCode == 200) {
    return wishListFromJson(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load wishlist');
  }
}