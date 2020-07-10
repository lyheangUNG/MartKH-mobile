import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:martkh/pages/account/edit_profile.dart';
import 'package:martkh/services/auth_api.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bloc.nagivation_bloc/navigation_bloc.dart';
import 'package:martkh/pages/account/viewimage.dart';
import 'package:easy_localization/easy_localization.dart';
// import '../sidebar/sidebar.dart';

class AcccountsPage extends StatefulWidget with NavigationStates {
  @override
  _AcccountsPageState createState() => _AcccountsPageState();
}

class _AcccountsPageState extends State<AcccountsPage> {
  var userData;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  
  File _image;
  String base64Image;
  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (localStorage.getString('user') != null) {
      var userJson = localStorage.getString('user');
      var user = json.decode(userJson);
      setState(() {
        userData = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return userData != null
        ? Scaffold(
            body: Stack(
            children: <Widget>[
              ClipPath(
                child: Container(color: Color(0xFFFBB140).withOpacity(0.8)),
                clipper: GetClipper(),
              ),
              Positioned(
                  width: MediaQuery.of(context).size.width,
                  top: MediaQuery.of(context).size.height / 5,
                  child: Column(
                    children: <Widget>[
                      // Container(
                      //     width: 150.0,
                      //     height: 150.0,
                      //     decoration: BoxDecoration(
                      //         color: Colors.red,
                      //         image: DecorationImage(
                      //             image: NetworkImage(
                      //                 "http://10.0.2.2:8000/uploads/avatar/" +
                      //            '${userData['avatar']}'),
                      //             fit: BoxFit.cover),
                      //         borderRadius: BorderRadius.all(Radius.circular(75.0)),
                      //         boxShadow: [
                      //           BoxShadow(blurRadius: 7.0, color: Colors.black)
                      //         ])),
                      GestureDetector(
                        onTap: () => _iconPress(),
                        child: CachedNetworkImage(
                          // imageUrl: "http://10.0.2.2:8000/uploads/avatar/" +
                          imageUrl:
                              "http://192.168.31.58:8000/uploads/avatar/" +
                                  '${userData['avatar']}',
                          imageBuilder: (context, imageProvider) => Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFFBB140),
                                width: 8,
                              ),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Text(
                        "${userData['name']}",
                        style: TextStyle(
                            fontSize: 36.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        "${userData['email']}",
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                      // SizedBox(height: 15.0),
                      // Text(
                      //   'Subscribe guys',
                      //   style: TextStyle(
                      //       fontSize: 17.0,
                      //       fontStyle: FontStyle.italic,
                      //       fontFamily: 'Montserrat'),
                      // ),
                      SizedBox(height: 25.0),
                      // Container(
                      //     height: 30.0,
                      //     width: 95.0,
                      //     child: Material(
                      //       borderRadius: BorderRadius.circular(20.0),
                      //       shadowColor: Colors.greenAccent,
                      //       color: Colors.green,
                      //       elevation: 7.0,
                      //       child: GestureDetector(
                      //         onTap: () {},
                      //         child: Center(
                      //           child: Text(
                      //             'Edit Name',
                      //             style: TextStyle(
                      //                 color: Colors.white,
                      //                 fontFamily: 'Montserrat'),
                      //           ),
                      //         ),
                      //       ),
                      //     )),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25.0),
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage(name: '${userData['name']}',email: '${userData['email']}')));
                            setState(() {
                              nameController.text = '${userData['name']}';
                              emailController.text = '${userData['email']}';
                            });
                            Alert(
                              context: context,
                              // title: "Edit Profile",
                              title: 'editprofile'.tr().toString(),
                              content: Column(
                                children: <Widget>[
                                  TextField(
                                    controller: nameController,
                                    // obscureText: true,
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.person),
                                      // labelText: 'Name',
                                      labelText: 'name'.tr().toString(),
                                    ),
                                  ),
                                  TextField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.email),
                                      labelText: 'email'.tr().toString(),
                                    ),
                                  ),
                                ],
                              ),
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    // "Save",
                                    'save'.tr().toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    _updateProfile();
                                  },
                                  color: Color.fromRGBO(0, 179, 134, 1.0),
                                ),
                                DialogButton(
                                  child: Text(
                                    'cancel'.tr().toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  gradient: LinearGradient(colors: [
                                    Color.fromRGBO(116, 116, 191, 1.0),
                                    Color.fromRGBO(52, 138, 199, 1.0)
                                  ]),
                                )
                              ],
                            ).show();
                          },
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Color(0xFFFBB140),
                          child: Text(
                            // 'Edit Profile',
                            'editprofile'.tr().toString(),
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        // padding: EdgeInsets.symmetric(vertical: 25.0),
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage(name: '${userData['name']}',email: '${userData['email']}')));
                            // setState(() {
                            //   nameController.text = '${userData['name']}';
                            //   emailController.text = '${userData['email']}';
                            // });
                            Alert(
                              context: context,
                              // title: "Change Password",
                              title: 'changepassword'.tr().toString(),
                              content: Column(
                                children: <Widget>[
                                  TextField(
                                    controller: currentPasswordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.lock),
                                      // labelText: 'Current Password',
                                      labelText: 'currentpassword'.tr().toString(),
                                    ),
                                  ),
                                  TextField(
                                    controller: newPasswordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.lock),
                                      // labelText: 'New Password',
                                      labelText: 'newpassword'.tr().toString(),
                                    ),
                                  ),
                                  TextField(
                                    controller: confirmNewPasswordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.lock),
                                      // labelText: 'Confirm New Password',
                                      labelText: 'confirmnewpassword'.tr().toString(),
                                    ),
                                  ),
                                ],
                              ),
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    // "Save",
                                    'save'.tr().toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    _resetPassword();
                                  },
                                  color: Color.fromRGBO(0, 179, 134, 1.0),
                                ),
                                DialogButton(
                                  child: Text(
                                    'cancel'.tr().toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  gradient: LinearGradient(colors: [
                                    Color.fromRGBO(116, 116, 191, 1.0),
                                    Color.fromRGBO(52, 138, 199, 1.0)
                                  ]),
                                )
                              ],
                            ).show();
                          },
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.red,
                          child: Text(
                            // 'Change Password',
                            'changepassword'.tr().toString(),
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //   padding: EdgeInsets.symmetric(vertical: 25.0),
                      //   width: MediaQuery.of(context).size.width/2.5,
                      //   child: RaisedButton(
                      //     elevation: 5.0,
                      //     onPressed: (){},
                      //     padding: EdgeInsets.all(15.0),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(30.0),
                      //     ),
                      //     color: Colors.red,
                      //     child: Text(
                      //       'Log out',
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //         letterSpacing: 1.5,
                      //         fontSize: 18.0,
                      //         fontWeight: FontWeight.w600,
                      //         fontFamily: 'OpenSans',
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ))
            ],
          ))
        : Center(
            child: Container(
              child: Text(
                "Access Denied",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
              ),
            ),
          );
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      base64Image = base64Encode(_image.readAsBytesSync());
      _uploadImage();
    }
  }

  void _uploadImage() async {
    var data = {'avatar': base64Image};
    var res = await CallApi()
        .uploadProfile(data, 'uploadProfileImage', '${userData['id']}');
    var body = json.decode(res.body);
    print(body);
    if (body['success']) {
      print(body['message'].toString());
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('user', json.encode(body['user']));
      if (localStorage.getString('user') != null) {
        var userJson = localStorage.getString('user');
        var user = json.decode(userJson);
        setState(() {
          userData = user;
        });
      }
      Alert(
        context: context,
        type: AlertType.success,
        // title: "Change Profile Image",
        title: 'changeprofileimage'.tr().toString(),
        desc: body['message'].toString(),
        buttons: [
          DialogButton(
            child: Text(
              // "OK",
              'ok'.tr().toString(),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
              Phoenix.rebirth(context);
            },
            width: 120,
            gradient: LinearGradient(colors: [
              Color.fromRGBO(116, 116, 191, 1.0),
              Color.fromRGBO(52, 138, 199, 1.0)
            ]),
          )
        ],
      ).show();
      // Navigator.pop(context);
    }
  }

  void _updateProfile() async {
    var data = {
      'name': nameController.text,
      'email': emailController.text,
    };
    var res =
        await CallApi().updateData(data, 'updateProfile', '${userData['id']}');
    var body = json.decode(res.body);
    // print(body);
    if (body['success']) {
      // print(body['message'].toString());
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('user', json.encode(body['user']));
      if (localStorage.getString('user') != null) {
        var userJson = localStorage.getString('user');
        var user = json.decode(userJson);
        setState(() {
          userData = user;
        });
      }
      Navigator.pop(context);
      Phoenix.rebirth(context);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => SideBarLayout()));
    }
  }

  void _resetPassword() async{
    var data = {
      'current_password': currentPasswordController.text,
      'password': newPasswordController.text,
      'password_confirmation': confirmNewPasswordController.text,
    };
    var res =
        await CallApi().postData(data, 'reset');
    var body = json.decode(res.body);
    print(body);
    if(body['success']){
      // SharedPreferences localStorage = await SharedPreferences.getInstance();
      // localStorage.setString('user', json.encode(body['user']));
      // if (localStorage.getString('user') != null) {
      //   var userJson = localStorage.getString('user');
      //   var user = json.decode(userJson);
      //   setState(() {
      //     userData = user;
      //   });
      // }
      setState(() {
        currentPasswordController.text = "";
        newPasswordController.text = "";
        confirmNewPasswordController.text = "";
      });
      Navigator.pop(context);
      Alert(
        context: context,
        type: AlertType.success,
        title: 'changepassword'.tr().toString(),
        // title: 'changeprofileimage'.tr().toString(),
        desc: body['message'].toString(),
        buttons: [
          DialogButton(
            child: Text(
              // "OK",
              'ok'.tr().toString(),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
              // Phoenix.rebirth(context);
            },
            width: 120,
            gradient: LinearGradient(colors: [
              Color.fromRGBO(116, 116, 191, 1.0),
              Color.fromRGBO(52, 138, 199, 1.0)
            ]),
          )
        ],
      ).show();
      // Phoenix.rebirth(context);
    }else{
      Alert(
        context: context,
        type: AlertType.error,
        title: "Password Reset failed",
        desc: body['message'].toString(),
        buttons: [
          DialogButton(
            child: Text(
              // "OK",
              'ok'.tr().toString(),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }

  }

  void _iconPress() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
              ),
            ),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.insert_photo),
                  // title: Text("View Image"),
                  title: Text('viewimage'.tr().toString()),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewImage(
                                image:
                                    "http://192.168.31.58:8000/uploads/avatar/" +
                                        '${userData['avatar']}')));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.insert_photo),
                  // title: Text("Upload Image From Gallery"),
                  title: Text('uploadimagefromgallery'.tr().toString()),
                  onTap: () {
                    getImage();
                    Navigator.pop(context);
                  },
                ),
                // ListTile(
                //   leading: Icon(Icons.insert_photo),
                //   title: Text("Cancel"),
                //   onTap: (){},
                // )
              ],
            ),
          );
        });
  }
}

class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    //implement shouldReclip
    return true;
  }
}
