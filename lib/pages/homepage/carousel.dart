import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  // 'assets/carousel/vegetable.jpg',
  // 'assets/carousel/wing.png'
  'https://www.wingmoney.com/wp-content/uploads/2017/11/mobile-mastercard.jpg',
  'https://www.wingmoney.com/wp-content/uploads/2018/01/wing-sentosa-mobile-banner.jpg'
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
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
          ),
        ))
    .toList();

class CarouselImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            // height: 200.0,
            autoPlay: true,
            // aspectRatio: 16/9,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
          ),
          items: imageSliders,
        ),
      ],
    );
  }
}
