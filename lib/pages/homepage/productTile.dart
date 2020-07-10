// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:martkh/pages/homepage/product-api.dart';
// import 'package:martkh/pages/homepage/product_details.dart';
// import 'package:martkh/pages/homepage/productlist.dart';
// import 'package:martkh/pages/homepage/products.dart';
// import 'package:flutter/foundation.dart';
// import 'package:async/async.dart';
// import 'package:martkh/themes/light_color.dart';
// import 'package:martkh/themes/title_text.dart';
// import 'package:martkh/themes/extensions.dart';

// enum ProductLoadMoreStatus { LOADING, STABLE }

// class ProductPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<ProductList>(
//         future: Products.fetchProducts(1),
//         builder: (context, snapshots) {
//           if (snapshots.hasError) return Text("Error Occurred");
//           switch (snapshots.connectionState) {
//             case ConnectionState.waiting:
//               return Center(child: CircularProgressIndicator());

//             case ConnectionState.done:
//               return ProductTile(products: snapshots.data);
//             default:
//           }
//         });
//   }
// }

// class ProductTile extends StatefulWidget {
//   final ProductList products;

//   ProductTile({Key key, this.products}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => ProductTileState();
// }

// class ProductTileState extends State<ProductTile> {
//   ProductLoadMoreStatus loadMoreStatus = ProductLoadMoreStatus.STABLE;
//   final ScrollController scrollController = ScrollController();
//   List<Product> products;
//   int currentPageNumber;
//   CancelableOperation productOperation;
//   // bool _isEndofPage = false;

//   @override
//   void initState() {
//     products = widget.products.products;
//     currentPageNumber = widget.products.page;
//     super.initState();
//   }

//   @override
//   void dispose() {
//     scrollController.dispose();
//     if (productOperation != null) productOperation.cancel();
//     super.dispose();
//   }

//   bool onNotification(ScrollNotification notification) {
//     // if (notification is ScrollEndNotification) {
//       // if (scrollController.position.maxScrollExtent > scrollController.offset &&
//       //     scrollController.position.maxScrollExtent - scrollController.offset <= 50) {
//         // if(scrollController.offset >= scrollController.position.maxScrollExtent &&
//         // !scrollController.position.outOfRange){
//          if(scrollController.position.pixels == scrollController.position.maxScrollExtent){ 
//         if (loadMoreStatus != null &&
//             loadMoreStatus == ProductLoadMoreStatus.STABLE) {
//           loadMoreStatus = ProductLoadMoreStatus.LOADING;
//           productOperation = CancelableOperation.fromFuture(
//               Products.fetchProducts(currentPageNumber + 1)
//                   .then((productsObject) {
//                 currentPageNumber = productsObject.page;
//                 loadMoreStatus = ProductLoadMoreStatus.STABLE;
//                 setState(() => products.addAll(productsObject.products));
//                 print(scrollController.offset);
//                 // if(currentPageNumber==productsObject.totalPages){
//                 //   print("nth to load");
//                 //   setState(() {
//                 //     _isEndofPage = true;
//                 //   });
//                 // }
//               })
//           );
//         }
//       }
//       // else {
//       //   print('out of range');
//       // }
//     // }
//     return true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final l = products.length;
//     return NotificationListener(
//       onNotification: onNotification,
//       child: 
//       // SliverGrid(
//       //   delegate: SliverChildBuilderDelegate(
//       //     (BuildContext context, int index) {
//       //       // Product product = snapshot.data[index];
//       //       return ProductListTile(product: products[index]);
//       //     },
//       //     childCount: products.length,
//       //   ),
//       //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//       //     crossAxisCount: 2,
//       //     childAspectRatio: MediaQuery.of(context).size.width /
//       //         (MediaQuery.of(context).size.height / 1.5),
//       //   ),
//       // ),

//       GridView.builder(
//         // scrollDirection: Axis.vertical,
//         shrinkWrap: true,
//         padding: EdgeInsets.only(
//           top: 5.0,
//         ),
//         // EdgeInsets.only
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 0.85,
//         ),
//         controller: scrollController,
//         itemCount: products.length,
//         physics: const AlwaysScrollableScrollPhysics(),
//         itemBuilder: (_, index) {
//           return ProductListTile(product: products[index]);
//         },
//       ),
//     );
//   }
// }

// class ProductListTile extends StatelessWidget {
//   ProductListTile({this.product});
//   final Product product;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: LightColor.background,
//         borderRadius: BorderRadius.all(Radius.circular(20)),
//         boxShadow: <BoxShadow>[
//           BoxShadow(color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
//         ],
//       ),
//       // margin: EdgeInsets.symmetric(vertical: !product.isSelected ? 20 : 0),
//       margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 5),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             // SizedBox(height: product.isSelected ? 15 : 0),
//             // SizedBox(height: 15),
//             Stack(
//               alignment: Alignment.center,
//               children: <Widget>[
//                 CircleAvatar(
//                   radius: 40,
//                   backgroundColor: LightColor.orange.withAlpha(40),
//                 ),
//                 // Text('http://127.0.0.1:8000/uploads/product_image/'+'${product.image}'),
//                 // Image.asset(productImage)
//                 // Image.network(
//                 //     'http://192.168.65.1/martkh/assets/product_image/' +
//                 //         '${product.image}'),
//                 CachedNetworkImage(
//                   imageUrl:
//                       // "http://10.0.2.2:8000/uploads/product_image/${product.image}",
//                       // "http://192.168.31.58:8000/uploads/product_image/${product.image}",
//                       "http://192.168.31.58:8000/uploads/product_image/" + product.image,
//                   progressIndicatorBuilder: (context, url, downloadProgress) =>
//                       CircularProgressIndicator(
//                           value: downloadProgress.progress),
//                   errorWidget: (context, url, error) => Icon(Icons.error),
//                 ),
//                 // Image(image:NetworkImageWithRetry('http://10.0.2.2:8000/uploads/product_image/'+'${product.image}')),

//                 // Image.network('http://10.0.2.2:8000/uploads/product_image/'+'${product.image}'),
//               ],
//             ),
//             // SizedBox(height: 5),
//             TitleText(
//               // text: '${product.name}',
//               text: product.name,
//               fontSize: 12,
//             ),
//             TitleText(
//               // text: 'US \$' + '${product.price}',
//               text: 'US \$' + product.price,
//               fontSize: 14,
//               // color: Colors.red,
//             ),
//           ],
//         ),
//       ).ripple(
//           () => Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => ProductDetails(pid: '${product.id}'),
//                 ),
//               ),
//           borderRadius: BorderRadius.all(Radius.circular(20))),
//     );
//   }
// }
