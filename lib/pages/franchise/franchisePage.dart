// import 'dart:convert';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:martkh/pages/homepage/product_details.dart';
import 'package:martkh/services/franchise-api.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
import '../../bloc.nagivation_bloc/navigation_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class FranchisePage extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FranchiseAppBar(),
      body: FutureBuilder(
          future: fetchFranchise(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  // WishList wishListProduct = snapshot.data[index];
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
                              child: Icon(Icons.store,size:50)
                              // CachedNetworkImage(
                              //   imageUrl:
                              //       // "http://10.0.2.2:8000/uploads/product_image/${snapshot.data[index].image}",
                              //       "http://192.168.31.58:8000/uploads/product_image/${snapshot.data[index].image}",
                              //   progressIndicatorBuilder:
                              //       (context, url, downloadProgress) =>
                              //           Center(
                              //             child: CircularProgressIndicator(
                              //                 value: downloadProgress.progress),
                              //           ),
                              //   errorWidget: (context, url, error) =>
                              //       Icon(Icons.error),
                              // ),
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
                                        '${snapshot.data[index].franchiseName}',
                                        // 'Franchise',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2.0)),
                                      Text(
                                        'Address : ' +
                                            '${snapshot.data[index].address}',
                                        style:
                                            const TextStyle(fontSize: 14.0),
                                      ),
                                      // const Padding(
                                      //     padding: EdgeInsets.symmetric(
                                      //         vertical: 1.0)),
                                      // Text(
                                      //   'Created at : ' +
                                      //       timeago.format(createAt),
                                      //   style:
                                      //       const TextStyle(fontSize: 12.0),
                                      // ),
                                    ],
                                  ),
                                )),
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              child: InkWell(
                                splashColor: Colors.white,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  // color: Colors.grey,
                                  size: 30,
                                ),
                                onTap: () {
                                  // Alert(
                                  //   context: context,
                                  //   type: AlertType.warning,
                                  //   // title: "Remove Product From Wishlist",
                                  //   title: 'removeproductfromwishlist'
                                  //       .tr()
                                  //       .toString(),
                                  //   // desc: "Are you sure?",
                                  //   desc: "areyousure".tr().toString() + " ?",
                                  //   buttons: [
                                  //     DialogButton(
                                  //       child: Text(
                                  //         // "Yes",
                                  //         'yes'.tr().toString(),
                                  //         style: TextStyle(
                                  //             color: Colors.white,
                                  //             fontSize: 20),
                                  //       ),
                                  //       onPressed: () {
                                  //         removeFromWishList(
                                  //             '${snapshot.data[index].pid}');
                                  //         Phoenix.rebirth(context);
                                  //         Navigator.pop(context);
                                  //       },
                                  //       // color: Color.fromRGBO(0, 179, 134, 1.0),
                                  //       color: Colors.red,
                                  //     ),
                                  //     DialogButton(
                                  //       child: Text(
                                  //         // "No",
                                  //         'no'.tr().toString(),
                                  //         style: TextStyle(
                                  //             color: Colors.white,
                                  //             fontSize: 20),
                                  //       ),
                                  //       onPressed: () => Navigator.pop(context),
                                  //       gradient: LinearGradient(colors: [
                                  //         Color.fromRGBO(116, 116, 191, 1.0),
                                  //         Color.fromRGBO(52, 138, 199, 1.0)
                                  //       ]),
                                  //     )
                                  //   ],
                                  // ).show();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => ProductDetails(
                      //       pid: '${snapshot.data[index].pid}',
                      //     ),
                      //   ),
                      // );
                    },
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  // void removeFromWishList(pid) async {
  //   await Wishlist().removeFromWishList(pid);
  //   // setstate(){
  //   //   wishlist = fetchWishList();
  //   // }
  //   // var body = json.decode(res.body);
  //   // print(body);
  //   // return body.toString();
  // }
}

class FranchiseAppBar extends StatelessWidget with PreferredSizeWidget {
  final double appBarHeight = 70.0;
  @override
  get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
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
                Padding(
                  padding: EdgeInsets.all(35),
                  child: Text(
                    // "Franchise",
                    'branch'.tr().toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 28,
                      color: Colors.white,
                      // color: Color(0xFFFB6340),
                    ),
                  ),
                ),
              ],
            ),
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
