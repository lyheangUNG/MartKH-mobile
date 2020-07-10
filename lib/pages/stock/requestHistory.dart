import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:intl/intl.dart';
import 'package:martkh/services/stock-api.dart';
import 'package:timeago/timeago.dart' as timeago;

class RequestHistory extends StatefulWidget {
  @override
  _RequestHistoryState createState() => _RequestHistoryState();
}

class _RequestHistoryState extends State<RequestHistory> {
  Future<void> refreshPage() async {
    await Future.delayed(Duration(seconds: 2));
    // Phoenix.rebirth(context);
  }

  Widget status(String stat) {
    if (stat == 'declined') {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), color: Colors.red),
          child: Text(
            'Declined',
            style: TextStyle(color: Colors.white),
          ));
    } else if (stat == 'approved') {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), color: Colors.green),
          child: Text('Approved', style: TextStyle(color: Colors.white)));
    } else {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), color: Colors.orange),
          child: Text('Pending', style: TextStyle(color: Colors.white)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RequestHistoryAppBar(title: "Request History"),
      body: RefreshIndicator(
        onRefresh: refreshPage,
        child: FutureBuilder(
            future: fetchFranchiseStockHistory(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // return Center(child: Text('hello'));
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    DateTime createAt = new DateFormat("yyyy-MM-dd hh:mm:ss").parse('${snapshot.data[index].createdAt}');
                    return Card(
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
                                        'Amount : '+'${snapshot.data[index].amount}',
                                        style: const TextStyle(fontSize: 14.0),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 1.0)),
                                      Text(
                                        'Created at : '+timeago.format(createAt),
                                        style: const TextStyle(fontSize: 12.0),
                                      ),
                                    ],
                                  ),
                                )
                            ),  
                            Container(
                              margin: EdgeInsets.only(right:5),
                              child: status('${snapshot.data[index].status}')
                            ), 
                          ],
                        ),
                      ),
                    );

                    // Container(
                    //   height: 100.0,
                    //   child: Card(
                    //     child: ListTile(
                    //       contentPadding: EdgeInsets.all(10),
                    //       leading: Container(
                    //         // padding: EdgeInsets.only(top: 10.0),
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
                    //       subtitle: Row(
                    //         children: <Widget>[
                    //           Text('Amount : ' + '${snapshot.data[index].amount}'),
                    //           Text('Created-at : ' + '7 months ago'),
                    //         ],
                    //       ),
                    //       trailing: status('${snapshot.data[index].status}'),
                    //       onTap: () {

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

class RequestHistoryAppBar extends StatelessWidget with PreferredSizeWidget {
  final double appBarHeight = 70.0;
  final title;

  RequestHistoryAppBar({Key key, this.title}) : super(key: key);
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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Center(
                  // padding: EdgeInsets.all(35),
                  child: Text(
                    // "MartKH",
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      color: Colors.white,
                      // color: Color(0xFFFB6340),
                    ),
                  ),
                ),
              ],
            ),
            leading: Container(
              // margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
              // child: ClipOval(
              //   child: Material(
              //     color: Colors.grey.withOpacity(0.2), // button color
              child: InkWell(
                splashColor: Colors.red, // inkwell color
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // showSearch(context: context, delegate: SearchProduct());
                },
              ),
              //   ),
              // ),
            ),
            // actions: <Widget>[
            //   Container(
            //     margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
            //     child: ClipOval(
            //       child: Material(
            //         color: Colors.grey.withOpacity(0.2), // button color
            //         child: InkWell(
            //           splashColor: Colors.red, // inkwell color
            //           child: SizedBox(
            //             width: 56,
            //             height: 56,
            //             child:
            //                 Icon(Icons.search, color: Colors.white, size: 30),
            //           ),
            //           onTap: () {
            //             // showSearch(context: context, delegate: SearchProduct());
            //           },
            //         ),
            //       ),
            //     ),
            //   ),
            // ],
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
