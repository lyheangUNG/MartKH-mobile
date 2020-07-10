import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi{
  // final String _url = 'http://10.0.2.2:8000/api/';
  final String _url = 'http://192.168.31.58:8000/api/';
  
  // postData(data, apiUrl) async {
  //   var fullUrl = _url + apiUrl;
  //   return http.post(
  //     fullUrl,
  //     body: jsonEncode(data),
  //     headers: _setHeaders(),
  //   );
  // }

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl + await _getToken();
    return http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl + await _getToken();
    // print(fullUrl);
    return await http.get(
      fullUrl,
      headers: _setHeaders()
    );
  }

  updateData(data,apiUrl,id) async {
    var fullUrl = _url + apiUrl +"/"+id.toString();
    // print(fullUrl);
    return await http.post(fullUrl,body: jsonEncode(data),headers: _setHeaders());
  }

  uploadProfile(data,apiUrl,id) async {
    var fullUrl = _url + apiUrl +"/"+id.toString();
    print(fullUrl);
    return await http.post(fullUrl,body: jsonEncode(data),headers: _setHeaders());
  }

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'applicaction/json',
  };

  _getToken() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    print(token);
    return '?token=$token'; 
  }

  // getUserInfo() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   if (localStorage.getString('user') != null) {
  //     var userJson = localStorage.getString('user');
  //     var user = json.decode(userJson);
  //     print(user);
  //     return user;
  //     // setState(() {
  //     //   userData = user;
  //     // });
  //   }
  // }

  // _getUserInfo() {}
  // void _checkIfLoggedIn() async{
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   var token = localStorage.getString('token');
  //   // if(token!=null){
  //   //   setState(() {
  //   //     _isLoggedIn = true;
  //   //   });
  //   // }
  // }
}