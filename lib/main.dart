import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splashscreen/splashscreen.dart';
// import 'package:martkh/pages/auth/login.dart';
import 'sidebar/sidebar_layout.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

// void main() => runApp(MyApp());
void main() => runApp(
  EasyLocalization(
      saveLocale: true,
      supportedLocales: [Locale('en', 'US'), Locale('km', 'KH')],
      path: 'assets/language', // <-- change patch to your
      fallbackLocale: Locale('en', 'US'),
      child: MyApp()
    ),
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    //lock Orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     statusBarColor: Color(0xFFFBB140),
    //     // statusBarBrightness: Brightness.light,
    // ));

    return MaterialApp(
      title: 'MartKH',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        // brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Color(0xFFFBB140),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'OpenSans',
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      // home: SideBarLayout(),
      home: Splashscreen(),
      // home: LoginPage() ,

    );
  }
}

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: SideBarLayout(),
      // title: Text('Welcome To MartKH',style: TextStyle(color: Color(0xFFFBB140),fontSize: 28),),
      image: Image.asset('assets/logos/martkhsplash.png'),
      backgroundColor: Colors.white,
      // styleTextUnderTheLoader: new TextStyle(),
      photoSize: MediaQuery.of(context).size.width/2.5,
      loaderColor: Color(0xFFFBB140)
    );
  }
}
