import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:martkh/bloc.nagivation_bloc/navigation_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
// import '../pages/homepage.dart';

import 'sidebar.dart';

class SideBarLayout extends StatefulWidget {
  @override
  _SideBarLayoutState createState() => _SideBarLayoutState();
}

class _SideBarLayoutState extends State<SideBarLayout> {
  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  @override
  Widget build(BuildContext context) {
    // String string;
    // switch (_source.keys.toList()[0]) {
    //   case ConnectivityResult.none:
    //     string = "Offline";
    //     break;
    //   case ConnectivityResult.mobile:
    //     string = "Mobile: Online";
    //     break;
    //   case ConnectivityResult.wifi:
    //     string = "WiFi: Online";
    // }
    bool isOnline;
    print(_source.keys);
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        isOnline = false;
        break;
      case ConnectivityResult.mobile:
        isOnline = true;
        break;
      case ConnectivityResult.wifi:
        isOnline = true;
    }

    return Scaffold(
      body: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(),
        child: Phoenix(
            // if (string == "Offline") {
            //   child:
            // } else {
            // }
            child: isOnline
                ? Stack(
                    children: <Widget>[
                      BlocBuilder<NavigationBloc, NavigationStates>(
                        builder: (context, navigationState) {
                          return navigationState as Widget;
                        },
                      ),
                      Sidebar(),
                    ],
                  )
                :Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('No internet Connection',style: TextStyle(fontSize: 24)),
                      SizedBox(height:10),
                      Text('Please connect to the internet to use this application',style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
            ),
      ),
    );
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }
}

class MyConnectivity {
  MyConnectivity._internal();

  static final MyConnectivity _instance = MyConnectivity._internal();

  static MyConnectivity get instance => _instance;

  Connectivity connectivity = Connectivity();

  StreamController controller = StreamController.broadcast();

  Stream get myStream => controller.stream;

  void initialise() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
    connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      } else
        isOnline = false;
    } on SocketException catch (_) {
      isOnline = false;
    }
    controller.sink.add({result: isOnline});
  }

  void disposeStream() => controller.close();
}
