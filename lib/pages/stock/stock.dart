import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:martkh/bloc.nagivation_bloc/navigation_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:martkh/pages/homepage/product_details.dart';
import 'package:martkh/pages/stock/requestStock.dart';
import 'package:martkh/services/stock-api.dart';
import 'package:martkh/pages/stock/requestHistory.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:timeago/timeago.dart' as timeago;

class StockManagement extends StatefulWidget with NavigationStates {
  @override
  _StockManagementState createState() => _StockManagementState();
}

class _StockManagementState extends State<StockManagement> {
  String franchiseName;
  // var franchiseStock;
  @override
  void initState() {
    getFranchiseName();
    super.initState();
  }

  Future<void> refreshPage() async {
    await Future.delayed(Duration(seconds: 2));
    Phoenix.rebirth(context);
  }

  getFranchiseName() async {
    var result = await fetchFranchiseStock();
    setState(() {
      // franchiseStock = result;
      franchiseName = result[0].franchiseName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StockManagementAppBar(
          title:
              franchiseName != null ? franchiseName : 'stock'.tr().toString()),
      body: RefreshIndicator(
        onRefresh: refreshPage,
        child: FutureBuilder(
            future: fetchFranchiseStock(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // return Center(child: Text('hello'));
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    DateTime createAt = new DateFormat("yyyy-MM-dd hh:mm:ss")
                        .parse('${snapshot.data[index].sfCreated}');
                    return GestureDetector(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      // "http://10.0.2.2:8000/uploads/product_image/${snapshot.data[index].image}",
                                      "http://192.168.31.58:8000/uploads/product_image/${snapshot.data[index].image}",
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                            child: CircularProgressIndicator(
                                                value: downloadProgress.progress),
                                          ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        5.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '${snapshot.data[index].name}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2.0)),
                                        Text(
                                          'Amount : ' +
                                              '${snapshot.data[index].amount}',
                                          style:
                                              const TextStyle(fontSize: 14.0),
                                        ),
                                        const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 1.0)),
                                        Text(
                                          'Created at : ' +
                                              timeago.format(createAt),
                                          style:
                                              const TextStyle(fontSize: 12.0),
                                        ),
                                      ],
                                    ),
                                  )),
                              Container(
                                  margin: EdgeInsets.only(right: 5),
                                  child: Icon(Icons.arrow_forward_ios)),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProductDetails(
                              pid: '${snapshot.data[index].productId}',
                            ),
                          ),
                        );
                      },
                    );
                    // Container(
                    //   height: 80.0,
                    //   child: Card(
                    //     child: ListTile(
                    //       leading: Container(
                    //         padding: EdgeInsets.only(top: 10.0),
                    //         child: CachedNetworkImage(
                    //           imageUrl:
                    //               // "http://10.0.2.2:8000/uploads/product_image/${snapshot.data[index].image}",
                    //               "http://192.168.31.58:8000/uploads/product_image/${snapshot.data[index].image}",
                    //           progressIndicatorBuilder:
                    //               (context, url, downloadProgress) =>
                    //                   CircularProgressIndicator(
                    //                       value: downloadProgress.progress),
                    //           errorWidget: (context, url, error) =>
                    //               Icon(Icons.error),
                    //         ),
                    //       ),
                    //       title: Text('${snapshot.data[index].name}'),
                    //       subtitle: Text(
                    //           'Amount : ' + '${snapshot.data[index].amount}'),
                    //       trailing: InkWell(
                    //         splashColor: Colors.white,
                    //         child: Icon(Icons.arrow_forward_ios,
                    //             color: Colors.grey),
                    //         onTap: () {},
                    //       ),
                    //       onTap: () {
                    //         Navigator.of(context).push(
                    //           MaterialPageRoute(
                    //             builder: (context) => ProductDetails(
                    //               pid: '${snapshot.data[index].productId}',
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //       // isThreeLine: true,
                    //     ),
                    //   ),
                    // );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}

class StockManagementAppBar extends StatelessWidget with PreferredSizeWidget {
  final double appBarHeight = 70.0;
  final String title;

  StockManagementAppBar({Key key, this.title}) : super(key: key);
  @override
  get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    // final double horizontalMargin = 5;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Wrap(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(25),
                  child: Text(
                    // "Wish List",
                    // 'stock'.tr().toString(),
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: Colors.white,
                      // color: Color(0xFFFB6340),
                    ),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.28,
                // margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
                padding: EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Material(
                    // color: Colors.grey.withOpacity(0.2), // button color
                    color: Colors.red, // button color
                    child: InkWell(
                      splashColor: Colors.blue, // inkwell color
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.history, color: Colors.white),
                            SizedBox(width: 5),
                            Text(
                              // "History",
                              'history'.tr().toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => RequestHistory(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.28,
                // margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
                padding: EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Material(
                    // color: Colors.grey.withOpacity(0.2), // button color
                    color: Colors.red, // button color
                    child: InkWell(
                      splashColor: Colors.blue, // inkwell color
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.trending_up, color: Colors.white),
                            SizedBox(width: 5),
                            Text(
                              // "Request",
                              'request'.tr().toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => StockRequest(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black54,
              blurRadius: 15.0,
              offset: Offset(0.0, 0.75))
        ],
        color: Color(0xFFFBB140),
      ),
    );
  }
}
