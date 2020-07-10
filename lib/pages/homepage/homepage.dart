import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:martkh/pages/homepage/appbar.dart';
// import 'package:martkh/pages/homepage/carousel.dart';
import 'package:martkh/pages/homepage/categoryPage.dart';
import 'package:martkh/pages/homepage/productPage.dart';
// import 'package:martkh/pages/homepage/productTile.dart';
// import 'package:martkh/pages/homepage/productlist.dart';
// import 'package:martkh/pages/homepage/product-api.dart';
// import 'package:martkh/pages/homepage/products.dart';
// import 'package:martkh/pages/homepage/searchProduct.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import '../../bloc.nagivation_bloc/navigation_bloc.dart';
import 'adsPage.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:martkh/pages/homepage/product_details.dart';
// import 'package:martkh/themes/light_color.dart';
// import 'package:martkh/themes/title_text.dart';
// import 'package:martkh/themes/extensions.dart';
// import 'package:martkh/pages/homepage/product-api.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget with NavigationStates {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Future<ProductList> products;
  @override
  void initState() {
    super.initState();
    // products = Products.fetchProducts(1);
  }

  Future<void> refreshPage() async{
    await Future.delayed(Duration(seconds: 2));
    // setState(() {
    //   // products = Products.fetchProducts(1);
    // });
    // return null;
    Phoenix.rebirth(context);
  }

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
    // print(await);
    return Scaffold(
      // appBar: MyAppBar(title: "MartKH"),
      appBar: MyAppBar(title: 'title'.tr().toString()),
      body: 
      RefreshIndicator(
        onRefresh: refreshPage,
        child: 
        Container(
          // color: Colors.grey,
          margin: EdgeInsets.symmetric(vertical: 5.0),

          child: 
          // FutureBuilder<ProductList>(
          //   // future: products,
          //   future: Products().fetchProducts(1),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       return 
                CustomScrollView(
                  // physics: NeverScrollableScrollPhysics(),
                  // primary: false,
                  slivers: <Widget>[
                    SliverList(
                        delegate: SliverChildListDelegate([
                      // CarouselImage(),
                      AdsList(),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            // 'Categories',
                            'categories'.tr().toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      CategoryList(),
                      Center(
                        child: Text(
                          // 'Latest Products',
                          'latestproducts'.tr().toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ])),
                    //Product List
                    SliverFillRemaining(
                      // hasScrollBody: true,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: ProductPage())
                      ),
                  ],
                ),
                    // SliverGrid(
                    //   delegate: SliverChildBuilderDelegate(
                    //     (BuildContext context, int index) {
                    //       Product product = snapshot.data[index];
                    //       return Container(
                    //         decoration: BoxDecoration(
                    //           color: LightColor.background,
                    //           borderRadius:
                    //               BorderRadius.all(Radius.circular(20)),
                    //           boxShadow: <BoxShadow>[
                    //             BoxShadow(
                    //                 color: Color(0xfff8f8f8),
                    //                 blurRadius: 15,
                    //                 spreadRadius: 10),
                    //           ],
                    //         ),
                    //         // margin: EdgeInsets.symmetric(vertical: !product.isSelected ? 20 : 0),
                    //         margin: EdgeInsets.symmetric(
                    //             vertical: 5, horizontal: 5),
                    //         child: Container(
                    //           padding: EdgeInsets.symmetric(horizontal: 5),
                    //           child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.center,
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceEvenly,
                    //             children: <Widget>[
                    //               // SizedBox(height: product.isSelected ? 15 : 0),
                    //               // SizedBox(height: 15),
                    //               Stack(
                    //                 alignment: Alignment.center,
                    //                 children: <Widget>[
                    //                   CircleAvatar(
                    //                     radius: 40,
                    //                     backgroundColor:
                    //                         LightColor.orange.withAlpha(40),
                    //                   ),
                    //                   // Text('http://127.0.0.1:8000/uploads/product_image/'+'${product.image}'),
                    //                   // Image.asset(productImage)
                    //                   // Image.network(
                    //                   //     'http://192.168.65.1/martkh/assets/product_image/' +
                    //                   //         '${product.image}'),
                    //                   CachedNetworkImage(
                    //                     imageUrl:
                    //                         // "http://10.0.2.2:8000/uploads/product_image/${product.image}",
                    //                         "http://192.168.31.58:8000/uploads/product_image/${product.image}",
                    //                     progressIndicatorBuilder: (context, url,
                    //                             downloadProgress) =>
                    //                         CircularProgressIndicator(
                    //                             value:
                    //                                 downloadProgress.progress),
                    //                     errorWidget: (context, url, error) =>
                    //                         Icon(Icons.error),
                    //                   ),
                    //                   // Image(image:NetworkImageWithRetry('http://10.0.2.2:8000/uploads/product_image/'+'${product.image}')),

                    //                   // Image.network('http://10.0.2.2:8000/uploads/product_image/'+'${product.image}'),
                    //                 ],
                    //               ),
                    //               // SizedBox(height: 5),
                    //               TitleText(
                    //                 text: '${product.name}',
                    //                 fontSize: 12,
                    //               ),
                    //               TitleText(
                    //                 text: 'US \$' + '${product.price}',
                    //                 fontSize: 14,
                    //                 // color: Colors.red,
                    //               ),
                    //             ],
                    //           ),
                    //         ).ripple(
                    //             // () => Navigator.of(context).push(
                    //             //       MaterialPageRoute(
                    //             //         builder: (context) => ProductDetails(
                    //             //           productId: '${product.id}',
                    //             //           productImage: '${product.image}',
                    //             //           productCode: '${product.code}',
                    //             //           productName: '${product.name}',
                    //             //           productDescription:
                    //             //               '${product.description}',
                    //             //           productPrice: '${product.price}',
                    //             //           productSize: '${product.size}',
                    //             //           productBrand: '${product.brand}',
                    //             //           productCountry: '${product.country}',
                    //             //           productSubcategoryId:
                    //             //               '${product.subcategoryId}',
                    //             //         ),
                    //             //       ),
                    //             //     ),
                    //             () => Navigator.of(context).push(
                    //                   MaterialPageRoute(
                    //                     builder: (context) => ProductDetails(
                    //                       pid: '${product.id}'
                    //                     ),
                    //                   ),
                    //                 ),
                    //             borderRadius:
                    //                 BorderRadius.all(Radius.circular(20))),
                    //       );
                    //     },
                    //     childCount: snapshot.data.length,
                    //   ),
                    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 2,
                    //     childAspectRatio: MediaQuery.of(context).size.width /
                    //         (MediaQuery.of(context).size.height / 1.5),
                    //   ),
                    // ),

                    // Container(
                    //     margin: EdgeInsets.all(15),
                    //     height: 320.0,
                    //     child: Products(),
                    // ),
                //   ],
                // ),
          //     } else {
          //       print('No data');
          //       return Center(child: CircularProgressIndicator());
          //     }
          //   },
          // ),
        ),
      // ),

      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(130),
      //   child: Stack(
      //     fit: StackFit.expand,
      //     children: <Widget>[
      //       Container(
      //         color: Colors.orange,
      //       ),
      //       Center(
      //         child: Text(
      //           "MartKH",
      //           style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      ),
    );

    // Center(
    //   child: Container(
    //     child: Text(
    //       "HomePage",
    //       style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),

    //     ),
    //   ),
    // );
  }
}

// Future getData() async{
//   var url = 'http://127.0.0.1/martkh/products.php';
//   http.Response response = await http.get(url);
//   var data = jsonDecode(response.body);
//   print(data.toString());
// }

// @override
// void initState(){
//   getData()
// }
