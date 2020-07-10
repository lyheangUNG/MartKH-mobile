import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../services/ads-api.dart';
import '../../models/ads-model.dart';

class AdsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.symmetric(horizontal: 12),
        // margin: EdgeInsets.only(left: 12),
        // height: 140.0,
        child: FutureBuilder<List<Ads>>(
            future: Advertisement().fetchAds(),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text("Error Occurred");
              // switch (snapshot.connectionState) {
              //   case ConnectionState.waiting:
              //     return Center(child: CircularProgressIndicator());

              //   case ConnectionState.done:
              //     return AdsTile(ads: snapshot.data);
              //   default:
              // }
              if (snapshot.hasData) {
                return CarouselSlider(
                    options: CarouselOptions(
                      // height: 200.0,
                      autoPlay: true,
                      // aspectRatio: 16/9,
                      aspectRatio: 16/9,
                      enlargeCenterPage: true,
                    ),
                    items: snapshot.data.map((item) {
                      return Builder(builder: (context) {
                        return Container(
                          margin: EdgeInsets.only(top:5.0),
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              child: Stack(
                                children: <Widget>[
                                  // Image.network(image,
                                  //     fit: BoxFit.cover, width: 1000.0),
                                  CachedNetworkImage(
                                    imageUrl:
                                        // "http://10.0.2.2:8000/uploads/product_image/${product.image}",
                                        // "http://192.168.31.58:8000/uploads/product_image/${product.image}",
                                        "http://192.168.31.58:8000/uploads/ads_image/template1/adsMiddle/" +
                                            item.image,
                                    imageBuilder: (context, imageProvider) => Container(
                                        // width: 1000.0,
                                        // height: 1000.0,
                                        decoration: BoxDecoration(
                                          // shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                              image: imageProvider, fit: BoxFit.cover),
                                        ),
                                      ),
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                  // Positioned(
                                  //   bottom: 0.0,
                                  //   left: 0.0,
                                  //   right: 0.0,
                                  //   child: Container(
                                  //     decoration: BoxDecoration(
                                  //       gradient: LinearGradient(
                                  //         colors: [
                                  //           Color.fromARGB(200, 0, 0, 0),
                                  //           Color.fromARGB(0, 0, 0, 0)
                                  //         ],
                                  //         begin: Alignment.bottomCenter,
                                  //         end: Alignment.topCenter,
                                  //       ),
                                  //     ),
                                  //     padding: EdgeInsets.symmetric(
                                  //         vertical: 10.0, horizontal: 20.0),
                                  //     child: Text(
                                  //       'No. ${imgList.indexOf(item)} image',
                                  //       style: TextStyle(
                                  //         color: Colors.white,
                                  //         fontSize: 20.0,
                                  //         fontWeight: FontWeight.bold,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              )),
                        );
                      });
                    }).toList());
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}