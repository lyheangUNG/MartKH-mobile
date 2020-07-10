// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:martkh/pages/auth/auth_api.dart';
// import 'package:martkh/pages/auth/register.dart';
// import 'package:martkh/sidebar/sidebar_layout.dart';
import 'package:martkh/themes/theme.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  final String name;
  final String email;
  // final password;

  const EditProfilePage({Key key, this.name, this.email}) : super(key: key);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // bool _rememberMe = false;
  bool _isLoading = false;
  // bool _isLoggedIn = ;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  
  @override
  void initState(){
    super.initState();
    emailController.text = widget.email;
    nameController.text = widget.name;
  }
  
  // ScaffoldState scaffoldState;
  // _showMsg(msg) { //
  //   final snackBar = SnackBar(
  //     content: Text(msg),
  //     action: SnackBarAction(
  //       label: 'Close',
  //       onPressed: () {
  //         // Some code to undo the change!
  //       },
  //     ),
  //   );
  //   Scaffold.of(context).showSnackBar(snackBar);
  // }

  Widget _buildNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Name',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: nameController,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Enter your Name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  // Widget _buildPasswordTF() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Text(
  //         'Password',
  //         style: kLabelStyle,
  //       ),
  //       SizedBox(height: 10.0),
  //       Container(
  //         alignment: Alignment.centerLeft,
  //         decoration: kBoxDecorationStyle,
  //         height: 60.0,
  //         child: TextField(
  //           controller: passwordController,
  //           obscureText: true,
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontFamily: 'OpenSans',
  //           ),
  //           decoration: InputDecoration(
  //             border: InputBorder.none,
  //             contentPadding: EdgeInsets.only(top: 14.0),
  //             prefixIcon: Icon(
  //               Icons.lock,
  //               color: Colors.white,
  //             ),
  //             hintText: 'Enter your Password',
  //             hintStyle: kHintTextStyle,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildForgotPasswordBtn() {
  //   return Container(
  //     alignment: Alignment.centerRight,
  //     child: FlatButton(
  //       onPressed: () => print('Forgot Password Button Pressed'),
  //       padding: EdgeInsets.only(right: 0.0),
  //       child: Text(
  //         'Forgot Password?',
  //         style: kLabelStyle,
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildRememberMeCheckbox() {
  //   return Container(
  //     height: 20.0,
  //     child: Row(
  //       children: <Widget>[
  //         Theme(
  //           data: ThemeData(unselectedWidgetColor: Colors.white),
  //           child: Checkbox(
  //             value: _rememberMe,
  //             checkColor: Colors.green,
  //             activeColor: Colors.white,
  //             onChanged: (value) {
  //               setState(() {
  //                 _rememberMe = value;
  //               });
  //             },
  //           ),
  //         ),
  //         Text(
  //           'Remember me',
  //           style: kLabelStyle,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildSaveBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){},
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          _isLoading ? 'Saving...' : 'Save',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  // Widget _buildSignInWithText() {
  //   return Column(
  //     children: <Widget>[
  //       Text(
  //         '- OR -',
  //         style: TextStyle(
  //           color: Colors.white,
  //           fontWeight: FontWeight.w400,
  //         ),
  //       ),
  //       SizedBox(height: 20.0),
  //       Text(
  //         'Sign in with',
  //         style: kLabelStyle,
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildSocialBtn(Function onTap, AssetImage logo) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       height: 60.0,
  //       width: 60.0,
  //       decoration: BoxDecoration(
  //         shape: BoxShape.circle,
  //         color: Colors.white,
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black26,
  //             offset: Offset(0, 2),
  //             blurRadius: 6.0,
  //           ),
  //         ],
  //         image: DecorationImage(
  //           image: logo,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildSocialBtnRow() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 30.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: <Widget>[
  //         _buildSocialBtn(
  //           () => print('Login with Facebook'),
  //           AssetImage(
  //             'assets/logos/facebook.jpg',
  //           ),
  //         ),
  //         _buildSocialBtn(
  //           () => print('Login with Google'),
  //           AssetImage(
  //             'assets/logos/google.jpg',
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildSignupBtn() {
  //   return GestureDetector(
  //     // onTap: () => Navigator.of(context).push(
  //     //   // MaterialPageRoute(
  //     //   //   // builder: (context) => RegisterPage(),
  //     //   // ),
  //     // ),
  //     child: RichText(
  //       text: TextSpan(
  //         children: [
  //           TextSpan(
  //             text: 'Don\'t have an Account? ',
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 18.0,
  //               fontWeight: FontWeight.w400,
  //             ),
  //           ),
  //           TextSpan(
  //             text: 'Sign Up',
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 18.0,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  //   colors: [
                  //     Color(0xFF73AEF5),
                  //     Color(0xFF61A4F1),
                  //     Color(0xFF478DE0),
                  //     Color(0xFF398AE5),
                  //   ],
                  //   stops: [0.1, 0.4, 0.7, 0.9],
                  // ),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFFFB6340),
                      Color(0xFFFBB140),
                    ],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 100.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            // color: Colors.black54,
                            // size: 15,
                            // padding: 12,
                            // isOutLine: true,
                            onTap: () {
                              Navigator.of(context).pop();
                              // BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageCLickedEvent);
                            },
                          ),
                          // SizedBox(width: MediaQuery.of(context).size.width/5),
                        ],
                      ),
                      Text(
                        'Edit Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildNameTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildEmailTF(),
                      // _buildPasswordTF(),
                      // _buildForgotPasswordBtn(),
                      // _buildRememberMeCheckbox(),
                      _buildSaveBtn(),
                      // _buildSignInWithText(),
                      // _buildSocialBtnRow(),
                      // _buildSignupBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // void _login() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   var data = {
  //     'email': emailController.text,
  //     'password': passwordController.text,
  //   };

  //   var res = await CallApi().postData(data, 'login');
  //   var body = json.decode(res.body);
  //   // print(body);
  //   // _showMsg(body['messsage']);
  //   if (body['success']) {
  //     print('login is successful');
  //     SharedPreferences localStorage = await SharedPreferences.getInstance();
  //     localStorage.setString('token', body['token']);
  //     localStorage.setString('user', json.encode(body['user']));
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => SideBarLayout()));
  //   } else {
  //     print('log in failed');
  //     // _showMsg(body['messsage']);
  //   }

  //   setState(() {
  //     _isLoading = false;
  //   });
  // }
}
