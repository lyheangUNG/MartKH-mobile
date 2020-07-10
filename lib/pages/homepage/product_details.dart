import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:martkh/pages/auth/login.dart';
import 'package:martkh/services/product-api.dart';
// import 'package:martkh/models/products.dart';
// import 'package:martkh/sidebar/sidebar_layout.dart';
import 'package:martkh/themes/light_color.dart';
import 'package:martkh/themes/theme.dart';
import 'package:martkh/themes/title_text.dart';
import 'package:martkh/themes/extensions.dart';
import 'package:martkh/services/wishlist-api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductDetails extends StatefulWidget {
  final pid;

  const ProductDetails({Key key, this.pid}) : super(key: key);
  // final productImage;
  // final productCode;
  // final productName;
  // final productDescription;
  // final productPrice;
  // final productSize;
  // final productBrand;
  // final productCountry;
  // final productSubcategoryId;

  // const ProductDetails(
  //     {Key key,
  //     this.pid
  //     // this.productImage,
  //     // this.productCode,
  //     // this.productName,
  //     // this.productDescription,
  //     // this.productPrice,
  //     // this.productSize,
  //     // this.productBrand,
  //     // this.productCountry,
  //     // this.productSubcategoryId
  //     })
  //     : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  // @override
  // Widget build(BuildContext context) {

  // }
  bool _isLiked = false;
  bool _isLoggedIn = false;
  var product = Map();

  @override
  void initState() {
    showProduct(widget.pid);
    super.initState();
    // checkWishList();
    _checkIfLoggedIn();
    // if (_isLoggedIn == true) {
    //   checkWishList();
    //   // addToWishList();
    // }
  }

  showProduct(pid) async {
    var res = await Products().showProduct(pid);
    var body = json.decode(res.body);
    setState(() {
      product = body[0];
    });
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      setState(() {
        _isLoggedIn = true;
        checkWishList();
      });
    }
  }

  void checkWishList() async {
    var res = await Wishlist().checkLikeOrNot(widget.pid);
    var body = json.decode(res.body);
    // print(body[0]);
    if (body.isNotEmpty) {
      // print(body[0]);
      setState(() {
        _isLiked = true;
      });
    }
  }

  addToWishList() async {
    var res = await Wishlist().addToWishList(widget.pid);
    var body = json.decode(res.body);
    // print(body);
    return body.toString();
    // setState(() {
    //   _isLiked = body;
    // });
    // if (body.isNotEmpty) {
    //   // print(body[0]);

    // }
  }

  Widget _appBar() {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // _icon(
          //   Icons.arrow_back_ios,
          //   color: Colors.black54,
          //   size: 15,
          //   padding: 12,
          //   isOutLine: true,
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //   },
          // ),
          GestureDetector(
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          _isLoggedIn ?
            _icon(_isLiked ? Icons.favorite : Icons.favorite_border,
              color: _isLiked ? LightColor.red : LightColor.lightGrey,
              size: 15,
              padding: 12,
              isOutLine: false, onPressed: () {      
                //make request to function addtoWishList to add to or remove from wishlist 
                // FutureBuilder(
                //   future: addToWishList(),
                //   builder: (context,snapshot){
                //     if(snapshot.hasData){
                //       return null;
                //     }
                //     else{
                //         return CircularProgressIndicator();
                //     }
                //   }
                // );
                addToWishList();
                setState(() {
                  _isLiked = !_isLiked;
                });
              }
            )
          : _icon(Icons.favorite_border,
              color: LightColor.lightGrey,
              size: 15,
              padding: 12,
              isOutLine: false, onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
              }
            ),
          
          // _icon(_isLiked ? Icons.favorite : Icons.favorite_border,
          //     color: _isLiked ? LightColor.red : LightColor.lightGrey,
          //     size: 15,
          //     padding: 12,
          //     isOutLine: false, onPressed: () {
          //       if (_isLoggedIn == true) {
          //         // Navigator.push(context,
          //         //     MaterialPageRoute(builder: (context) => SideBarLayout()));
          //         // setState(() {
          //         //   _isLiked = !_isLiked;
          //         //   // var body = addToWishList();
          //         //   // print(body);
          //         // });
                  
          //       } else {
          //         Navigator.push(context,
          //             MaterialPageRoute(builder: (context) => LoginPage()));
          //       }
          //     }),
        ],
      ),
    );
  }

  Widget _icon(
    IconData icon, {
    // Color color = LightColor.iconColor,
    Color color = Colors.red,
    double size = 20,
    double padding = 10,
    bool isOutLine = false,
    Function onPressed,
  }) {
    return Container(
      height: 40,
      width: 40,
      padding: EdgeInsets.all(padding),
      // margin: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(
            // color: LightColor.iconColor,
            color: Colors.blue,
            style: isOutLine ? BorderStyle.solid : BorderStyle.none),
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color:
            isOutLine ? Colors.transparent : Theme.of(context).backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Color(0xfff8f8f8),
              blurRadius: 5,
              spreadRadius: 10,
              offset: Offset(5, 5)),
        ],
      ),
      child: Icon(icon, color: color, size: size),
    ).ripple(() {
      if (onPressed != null) {
        onPressed();
      }
    }, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  Widget _productImage() {
    return product.isEmpty? Center(child: CircularProgressIndicator()) : 
    Container(
      // color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 70),
      // child: Image.asset('assets/products/monster.jpg'),
      child: CachedNetworkImage(
        imageUrl:
            // "http://10.0.2.2:8000/uploads/product_image/" + widget.productImage,
            // "http://192.168.31.58:8000/uploads/product_image/" +
            //     widget.productImage,
            "http://192.168.31.58:8000/uploads/product_image/" +
                product['image'],
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  // // Widget _categoryWidget() {
  // //   return Container(
  // //     margin: EdgeInsets.symmetric(vertical: 0),
  // //     width: AppTheme.fullWidth(context),
  // //     height: 80,
  // //     child: Row(
  // //       crossAxisAlignment: CrossAxisAlignment.start,
  // //       mainAxisAlignment: MainAxisAlignment.center,
  // //       children: <Widget>[
  // //         Text("Beverages"),
  // //       ],
  // //       // children:
  // //       // AppData.showThumbnailList.map((x) => _thumbnail(x)).toList()
  // //     ),
  // //   );
  // // }

  // // Widget _thumbnail(String image) {
  // //   return Container(
  // //     margin: EdgeInsets.symmetric(horizontal: 10),
  // //     child: Container(
  // //       height: 40,
  // //       width: 50,
  // //       decoration: BoxDecoration(
  // //         border: Border.all(
  // //           color: LightColor.grey,
  // //         ),
  // //         borderRadius: BorderRadius.all(Radius.circular(13)),
  // //         // color: Theme.of(context).backgroundColor,
  // //       ),
  // //       child: Image.asset(image),
  // //     ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13))),
  // //   );
  // // }

  Widget _detailWidget() {
    return DraggableScrollableSheet(
      maxChildSize: .8,
      initialChildSize: .53,
      minChildSize: .53,
      builder: (context, scrollController) {
        return Container(
          padding: AppTheme.padding.copyWith(bottom: 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 5),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                        color: LightColor.iconColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 100,
                  child: Wrap(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // alignment: WrapAlignment.spaceBetween,
                    runAlignment: WrapAlignment.spaceBetween,
                    children: <Widget>[
                      // TitleText(text: widget.productName, fontSize: 25),
                      TitleText(text: product.isEmpty?'':product['name'], fontSize: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TitleText(
                                // text: "Price : ",
                                text: 'price'.tr().toString()+ " : ",
                                fontSize: 18,
                              ),
                              TitleText(
                                text: "US \$ ",
                                fontSize: 18,
                                color: LightColor.red,
                              ),
                              TitleText(
                                // text: widget.productPrice,
                                text:  product.isEmpty? '': product['price'].toString(),
                                fontSize: 25,
                              ),
                            ],
                          ),
                          // Rating
                          // Row(
                          //   children: <Widget>[
                          //     Icon(Icons.star,
                          //         color: LightColor.yellowColor, size: 17),
                          //     Icon(Icons.star,
                          //         color: LightColor.yellowColor, size: 17),
                          //     Icon(Icons.star,
                          //         color: LightColor.yellowColor, size: 17),
                          //     Icon(Icons.star,
                          //         color: LightColor.yellowColor, size: 17),
                          //     Icon(Icons.star_border, size: 17),
                          //   ],
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TitleText(
                      // text: "Size :  ",
                      text: 'size'.tr().toString()+ " : ",
                      fontSize: 18,
                    ),
                    SizedBox(width: 20),
                    TitleText(
                      // text: widget.productSize,
                      text: product.isEmpty? '': product['size'],
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TitleText(
                      // text: "Country :  ",
                      text: 'size'.tr().toString()+ " : ",
                      fontSize: 18,
                    ),
                    SizedBox(width: 20),
                    TitleText(
                      // text: widget.productCountry,
                      text: product.isEmpty? '': product['country'],
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TitleText(
                      // text: "Brand :  ",
                      text: 'brand'.tr().toString()+ " : ",
                      fontSize: 18,
                    ),
                    SizedBox(width: 20),
                    TitleText(
                      // text: widget.productBrand,
                      text: product.isEmpty? '': product['brand'],
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                // _availableSize(),
                SizedBox(
                  height: 20,
                ),
                // _availableColor(),
                // SizedBox(
                //   height: 20,
                // ),
                _description(),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget _availableSize() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       TitleText(
  //         text: "Available Size",
  //         fontSize: 14,
  //       ),
  //       SizedBox(height: 20),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: <Widget>[
  //           _sizeWidget("US 6"),
  //           _sizeWidget("US 7", isSelected: true),
  //           _sizeWidget("US 8"),
  //           _sizeWidget("US 9"),
  //         ],
  //       )
  //     ],
  //   );
  // }

  // Widget _sizeWidget(String text,
  //     {Color color = LightColor.iconColor, bool isSelected = false}) {
  //   return Container(
  //     padding: EdgeInsets.all(10),
  //     decoration: BoxDecoration(
  //       border: Border.all(
  //           color: LightColor.iconColor,
  //           style: !isSelected ? BorderStyle.solid : BorderStyle.none),
  //       borderRadius: BorderRadius.all(Radius.circular(13)),
  //       color:
  //           isSelected ? LightColor.orange : Theme.of(context).backgroundColor,
  //     ),
  //     child: TitleText(
  //       text: text,
  //       fontSize: 16,
  //       color: isSelected ? LightColor.background : LightColor.titleTextColor,
  //     ),
  //   ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)));
  // }

  // Widget _availableColor() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       TitleText(
  //         text: "Available Size",
  //         fontSize: 14,
  //       ),
  //       SizedBox(height: 20),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: <Widget>[
  //           _colorWidget(LightColor.yellowColor, isSelected: true),
  //           SizedBox(
  //             width: 30,
  //           ),
  //           _colorWidget(LightColor.lightBlue),
  //           SizedBox(
  //             width: 30,
  //           ),
  //           _colorWidget(LightColor.black),
  //           SizedBox(
  //             width: 30,
  //           ),
  //           _colorWidget(LightColor.red),
  //           SizedBox(
  //             width: 30,
  //           ),
  //           _colorWidget(LightColor.skyBlue),
  //         ],
  //       )
  //     ],
  //   );
  // }

  // Widget _colorWidget(Color color, {bool isSelected = false}) {
  //   return CircleAvatar(
  //     radius: 12,
  //     backgroundColor: color.withAlpha(150),
  //     child: isSelected
  //         ? Icon(
  //             Icons.check_circle,
  //             color: color,
  //             size: 18,
  //           )
  //         : CircleAvatar(radius: 7, backgroundColor: color),
  //   );
  // }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          // text: "Description",
          text: 'description'.tr().toString()+ " : ",
          fontSize: 18,
          overflow: TextOverflow.visible,
        ),
        SizedBox(height: 20),
        // Text(widget.productDescription),
        Text( product.isEmpty? '':product['description']),
      ],
    );
  }

  // FloatingActionButton _flotingButton() {
  //   return FloatingActionButton(
  //     onPressed: () {},
  //     backgroundColor: LightColor.orange,
  //     child: Icon(Icons.shopping_basket,
  //         color: Theme.of(context).floatingActionButtonTheme.backgroundColor),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: _flotingButton(),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xfffbfbfb),
              Color(0xfff7f7f7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  _appBar(),
                  _productImage(),
                  // _categoryWidget(),
                ],
              ),
              _detailWidget()
            ],
          ),
        ),
      ),
    );
  }
}
