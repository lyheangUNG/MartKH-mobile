import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
// import 'package:martkh/pages/account/accountpage.dart';
// import 'package:martkh/pages/accountpage.dart';
import 'package:martkh/services/auth_api.dart';
import 'package:martkh/pages/auth/login.dart';
import 'package:martkh/pages/stock/stock.dart';
import 'package:martkh/sidebar/sidebar_layout.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc.nagivation_bloc/navigation_bloc.dart';
import '../sidebar/menu_item.dart';
import 'package:rxdart/rxdart.dart';
import 'package:easy_localization/easy_localization.dart';


class Sidebar extends StatefulWidget {
  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar>
    with SingleTickerProviderStateMixin<Sidebar> {
  bool _isLoggedIn = false;
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenStreamController;
  Stream<bool> isSidebarOpenStream;
  StreamSink<bool> isSidebarOpenSink;
  // final bool isSidebarOpen = true;
  final _animationDuration = const Duration(milliseconds: 200);
  var userData;
  String role;

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenStreamController = PublishSubject<bool>();
    isSidebarOpenStream = isSidebarOpenStreamController.stream;
    isSidebarOpenSink = isSidebarOpenStreamController.sink;
    _getUserInfo();
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenStreamController.close();
    isSidebarOpenSink.close();
    super.dispose();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    // print(token);
    if (token != null) {
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    // print(_isLoggedIn);
    if (localStorage.getString('user') != null) {
      var userJson = localStorage.getString('user');
      // var token = localStorage.getString('token');
      var user = json.decode(userJson);
      // print(user['name']);
      setState(() {
        userData = user;
        role = user['role'];
        // _isLoggedIn = true;
        // print(_isLoggedIn);
      });
    }
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // print(screenWidth);
    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenStream,
      builder: (context, isSideBarOpenAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          // left: isSidebarOpen ? 0 : 0,
          // right: isSidebarOpen ? 0 : screenWidth - 45,
          left: isSideBarOpenAsync.data ? 0 : -screenWidth,
          right: isSideBarOpenAsync.data ? 0 : screenWidth - 43,
          child: Row(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    // color: const Color(0xFF262AAA),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xFFFB6340),
                          Color(0xFFFBB140),
                        ],
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        userData != null
                            ? ListTile(
                                title: Text(
                                  "${userData['name']}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800),
                                ),
                                subtitle: Text(
                                  // "lyheang@gmail.com",
                                  "${userData['email']}",
                                  style: TextStyle(
                                    color: Color(0xFFFFDF77),
                                    fontSize: 16,
                                  ),
                                ),
                                leading: CachedNetworkImage(
                                  imageUrl:
                                      // "http://10.0.2.2:8000/uploads/avatar/" +
                                      "http://192.168.31.58:8000/uploads/avatar/" +
                                          '${userData['avatar']}',
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: 60.0,
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ))
                            : ListTile(
                                title: Text(
                                  // "Guest",
                                  'guest'.tr().toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800),
                                ),
                                leading: CircleAvatar(
                                  child: Icon(
                                    Icons.perm_identity,
                                    color: Color(0xFFFB6340),
                                  ),
                                  radius: 40,
                                ),
                              ),
                        Divider(
                          // height: 64,
                          height: 36,
                          thickness: 0.5,
                          color: Colors.white.withOpacity(0.5),
                          indent: 32,
                          endIndent: 32,
                        ),
                        MenuItem(
                          icon: Icons.home,
                          // title: "Home",
                          title: 'home'.tr().toString(),
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.HomePageCLickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.person,
                          // title: "My Account",
                          title: "myaccount".tr().toString(),
                          onTap: () {
                            onIconPressed();
                            _isLoggedIn
                                ? BlocProvider.of<NavigationBloc>(context)
                                    .add(NavigationEvents.MyAccountClickedEvent)
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => AcccountsPage(userData: '${userData['name']}')))
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                          },
                        ),
                        MenuItem(
                          icon: Icons.favorite,
                          // title: "Wish List",
                          title: "wishlist".tr().toString(),
                          onTap: () {
                            onIconPressed();
                            // BlocProvider.of<NavigationBloc>(context)
                            //     .add(NavigationEvents.WishListPageClickedEvent);
                            _isLoggedIn
                                ? BlocProvider.of<NavigationBloc>(context).add(
                                    NavigationEvents.WishListPageClickedEvent)
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => AcccountsPage(userData: '${userData['name']}')))
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                          },
                        ),
                        MenuItem(
                          icon: Icons.store,
                          // title: "Franchise",
                          title: "branch".tr().toString(),
                          onTap: () {
                            onIconPressed();
                            // BlocProvider.of<NavigationBloc>(context)
                            //     .add(NavigationEvents.WishListPageClickedEvent);
                            // _isLoggedIn
                            //     ? 
                                BlocProvider.of<NavigationBloc>(context).add(
                                    NavigationEvents.FranchiseClickedEvent);
                                // : Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => LoginPage()));
                          },
                        ),
                        role=='franchise'? MenuItem(
                          icon: Icons.local_mall,
                          // title: "Wish List",
                          title: "stock".tr().toString(),
                          onTap: () {
                            onIconPressed();
                            // BlocProvider.of<NavigationBloc>(context)
                            //     .add(NavigationEvents.WishListPageClickedEvent);
                            _isLoggedIn
                                ? BlocProvider.of<NavigationBloc>(context).add(
                                    NavigationEvents.StockRequestClickedEvent)
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => AcccountsPage(userData: '${userData['name']}')))
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StockManagement()));
                          },
                        )
                        : Container(),
                        Divider(
                          height: 36,
                          thickness: 0.5,
                          color: Colors.white.withOpacity(0.5),
                          indent: 32,
                          endIndent: 32,
                        ),
                        MenuItem(
                          icon: Icons.settings,
                          // title: "Settings",
                          title: "settings".tr().toString(),
                        ),
                        MenuItem(
                          icon: Icons.help,
                          // title: "Help",
                          title: "aboutus".tr().toString(),
                        ),
                        userData != null
                            ? MenuItem(
                                icon: Icons.exit_to_app,
                                // title: "Log out",
                                title: "logout".tr().toString(),
                                onTap: () {
                                  // print('logout');
                                  // logout();
                                  Alert(
                                    context: context,
                                    type: AlertType.warning,
                                    // title: "Log out",
                                    title: 'logout'.tr().toString()+" ?",
                                    // desc: "Are you sure?",
                                    desc: 'areyousure'.tr().toString(),
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          // "Log out",
                                          'logout'.tr().toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        onPressed: () => logout(),
                                        // color: Color.fromRGBO(0, 179, 134, 1.0),
                                        color: Colors.red,
                                      ),
                                      DialogButton(
                                        child: Text(
                                          // "Cancel",
                                          'cancel'.tr().toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
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
                              )
                            : Container(),
                        Divider(
                          height: 36,
                          thickness: 0.5,
                          color: Colors.white.withOpacity(0.5),
                          indent: 32,
                          endIndent: 32,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                print("eng ");
                                setState(() {
                                  EasyLocalization.of(context).locale = Locale('en','US');
                                });
                                Phoenix.rebirth(context);
                              },
                              child: Container(
                                width: 50,
                                child: Image.asset('assets/flags/US.png'),
                              )
                            ),
                            GestureDetector(
                              onTap: (){
                                print("kh");
                                setState(() {
                                  EasyLocalization.of(context).locale = Locale('km','KH');
                                });
                                Phoenix.rebirth(context);
                              },
                              child: Container(
                                width: 50,
                                child: Image.asset('assets/flags/cambodia.png'),
                              )
                            ),
                          ],
                        )
                        // MenuItem(
                        //   icon: Icons.help,
                        //   title: "Help",
                        // ),
                        // MenuItem(
                        //   icon: Icons.help,
                        //   title: "Help",
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      // color: Color(0xFF262AAA),
                      color: Color(0xFFFB6340),
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        icon: AnimatedIcons.menu_close,
                        progress: _animationController.view,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  // void toLogin(){
  //   Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => LoginPage()));
  // }

  void logout() async {
    //logout from server
    var res = await CallApi().getData('logout');
    var body = json.decode(res.body);
    print(body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      _isLoggedIn = false;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SideBarLayout()));
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => LoginPage()));
      // BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageCLickedEvent);
      Phoenix.rebirth(context);
    } else {
      print('fail');
    }
    // print(body);
    //clear the user

    //clear the token
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // throw UnimplementedError();
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // throw UnimplementedError();
    return true;
  }
}
