// import 'dart:convert';

//1
// List<Product> productFromJson(String str) =>
//     List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

// String productToJson(List<Product> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Product {
//   Product({
//     this.id,
//     this.image,
//     this.code,
//     this.name,
//     this.description,
//     this.price,
//     this.size,
//     this.brand,
//     this.country,
//     this.subcategoryId,
//     this.view,
//     this.createdAt,
//     // this.updatedAt,
//   });

//   int id;
//   String image;
//   String code;
//   String name;
//   String description;
//   double price;
//   String size;
//   String brand;
//   String country;
//   int subcategoryId;
//   dynamic view;
//   DateTime createdAt;
//   // DateTime updatedAt;

//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//         id: json["id"],
//         image: json["image"],
//         code: json["code"],
//         name: json["name"],
//         description: json["description"],
//         price: json["price"].toDouble(),
//         size: json["size"],
//         brand: json["brand"],
//         country: json["country"],
//         subcategoryId: json["subcategory_id"],
//         view: json["view"],
//         createdAt: DateTime.parse(json["created_at"]),
//         // updatedAt: DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "image": image,
//         "code": code,
//         "name": name,
//         "description": description,
//         "price": price,
//         "size": size,
//         "brand": brand,
//         "country": country,
//         "subcategory_id": subcategoryId,
//         "view": view,
//         "created_at": createdAt.toIso8601String(),
//         // "updated_at": updatedAt.toIso8601String(),
//       };
// }

//2
import 'dart:convert';

// ProductList productListFromJson(String str) => ProductList.fromJson(json.decode(str));

// String productListToJson(ProductList products) => json.encode(products.toJson());

// class ProductList {
//     ProductList({
//         this.currentPage,
//         this.products,
//         this.firstPageUrl,
//         this.from,
//         this.lastPage,
//         this.lastPageUrl,
//         this.nextPageUrl,
//         this.path,
//         this.perPage,
//         this.prevPageUrl,
//         this.to,
//         this.total,
//     });

//     int currentPage;
//     List<Product> products;
//     String firstPageUrl;
//     int from;
//     int lastPage;
//     String lastPageUrl;
//     String nextPageUrl;
//     String path;
//     int perPage;
//     dynamic prevPageUrl;
//     int to;
//     int total;

//     factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
//         currentPage: json["current_page"],
//         products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
//         firstPageUrl: json["first_page_url"],
//         from: json["from"],
//         lastPage: json["last_page"],
//         lastPageUrl: json["last_page_url"],
//         nextPageUrl: json["next_page_url"],
//         path: json["path"],
//         perPage: json["per_page"],
//         prevPageUrl: json["prev_page_url"],
//         to: json["to"],
//         total: json["total"],
//     );

//     Map<String, dynamic> toJson() => {
//         "current_page": currentPage,
//         "products": List<dynamic>.from(products.map((x) => x.toJson())),
//         "first_page_url": firstPageUrl,
//         "from": from,
//         "last_page": lastPage,
//         "last_page_url": lastPageUrl,
//         "next_page_url": nextPageUrl,
//         "path": path,
//         "per_page": perPage,
//         "prev_page_url": prevPageUrl,
//         "to": to,
//         "total": total,
//     };
// }

// class Product {
//     Product({
//         this.id,
//         this.image,
//         this.code,
//         this.name,
//         this.description,
//         this.price,
//         this.size,
//         this.brand,
//         this.country,
//         this.subcategoryId,
//         this.view,
//         this.createdAt,
//         // this.updatedAt,
//     });

//     int id;
//     String image;
//     String code;
//     String name;
//     String description;
//     double price;
//     String size;
//     String brand;
//     String country;
//     int subcategoryId;
//     String view;
//     DateTime createdAt;
//     // DateTime updatedAt;

//     factory Product.fromJson(Map<String, dynamic> json) => Product(
//         id: json["id"],
//         image: json["image"],
//         code: json["code"],
//         name: json["name"],
//         description: json["description"],
//         price: json["price"].toDouble(),
//         size: json["size"],
//         brand: json["brand"],
//         country: json["country"],
//         subcategoryId: json["subcategory_id"],
//         view: json["view"] == null ? null : json["view"],
//         createdAt: DateTime.parse(json["created_at"]),
//         // updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "image": image,
//         "code": code,
//         "name": name,
//         "description": description,
//         "price": price,
//         "size": size,
//         "brand": brand,
//         "country": country,
//         "subcategory_id": subcategoryId,
//         "view": view == null ? null : view,
//         "created_at": createdAt.toIso8601String(),
//         // "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
//     };
// }

//3
List<Product> productFromMap(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromMap(x)));

String productToMap(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
class Product {
  Product({
      this.id,
      this.image,
      this.code,
      this.name,
      this.description,
      this.price,
      this.size,
      this.brand,
      this.country,
      this.subcategoryId,
      this.view,
      // this.createdAt,
      // this.updatedAt,
      });
  final String id, image, code, name,description,price,size,brand,country,subcategoryId,view;
  factory Product.fromJson(Map value) {
    return Product(
        // title: value['title'],
        // posterPath: value['poster_path'],
        // id: value['id'].toString(),
        // overview: value['overview'],
        // voteAverage: value['vote_average'].toString(),
        // favored: false
        id: value["id"].toString(),
        image: value["image"],
        code: value["code"],
        name: value["name"],
        description: value["description"],
        price: value["price"].toString(),
        size: value["size"],
        brand: value["brand"],
        country: value["country"],
        subcategoryId: value["subcategory_id"].toString(),
        view: value["view"] == null ? null : value["view"],
        // createdAt: DateTime.parse(value["created_at"]),
        );
  }
  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"].toString(),
        image: json["image"],
        code: json["code"],
        name: json["name"],
        description: json["description"],
        price: json["price"].toString(),
        size: json["size"],
        brand: json["brand"],
        country: json["country"],
        subcategoryId: json["subcategory_id"].toString(),
        view: json["view"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "image": image,
        "code": code,
        "name": name,
        "description": description,
        "price": price,
        "size": size,
        "brand": brand,
        "country": country,
        "subcategory_id": subcategoryId,
        "view": view,
    };

  // Product.fromMap(Map<String, dynamic> value)
  //     : page = value['current_page'],
  //       totalResults = value['total'],
  //       totalPages = value['last_page'],
  //       products = List<Product>.from(
  //           value['data'].map((products) => Product.fromJson(products)));
}




// class Products extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.width);
    // print(MediaQuery.of(context).size.height);


    // return FutureBuilder(
    //   future: fetchProducts(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       return SliverGrid(
    //         delegate:
    //             SliverChildBuilderDelegate((BuildContext context, int index) {
    //           Product product = snapshot.data[index];
    //           return Container(
    //             decoration: BoxDecoration(
    //               color: LightColor.background,
    //               borderRadius: BorderRadius.all(Radius.circular(20)),
    //               boxShadow: <BoxShadow>[
    //                 BoxShadow(
    //                     color: Color(0xfff8f8f8),
    //                     blurRadius: 15,
    //                     spreadRadius: 10),
    //               ],
    //             ),
    //             // margin: EdgeInsets.symmetric(vertical: !product.isSelected ? 20 : 0),
    //             margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    //             child: Container(
    //               padding: EdgeInsets.symmetric(horizontal: 5),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                 children: <Widget>[
    //                   // SizedBox(height: product.isSelected ? 15 : 0),
    //                   // SizedBox(height: 15),
    //                   Stack(
    //                     alignment: Alignment.center,
    //                     children: <Widget>[
    //                       CircleAvatar(
    //                         radius: 40,
    //                         backgroundColor: LightColor.orange.withAlpha(40),
    //                       ),
    //                       // Text('http://127.0.0.1:8000/uploads/product_image/'+'${product.image}'),
    //                       // Image.asset(productImage)
    //                       // Image.network(
    //                       //     'http://192.168.65.1/martkh/assets/product_image/' +
    //                       //         '${product.image}'),
    //                       CachedNetworkImage(
    //                         imageUrl:
    //                             "http://10.0.2.2:8000/uploads/product_image/${product.image}",
    //                         progressIndicatorBuilder:
    //                             (context, url, downloadProgress) =>
    //                                 CircularProgressIndicator(
    //                                     value: downloadProgress.progress),
    //                         errorWidget: (context, url, error) =>
    //                             Icon(Icons.error),
    //                       ),
    //                       // Image(image:NetworkImageWithRetry('http://10.0.2.2:8000/uploads/product_image/'+'${product.image}')),

    //                       // Image.network('http://10.0.2.2:8000/uploads/product_image/'+'${product.image}'),
    //                     ],
    //                   ),
    //                   // SizedBox(height: 5),
    //                   TitleText(
    //                     text: '${product.name}',
    //                     fontSize: 12,
    //                   ),
    //                   TitleText(
    //                     text: 'US \$' + '${product.price}',
    //                     fontSize: 14,
    //                     // color: Colors.red,
    //                   ),
    //                 ],
    //               ),
    //             ).ripple(
    //                 // () {},
    //                 () => Navigator.of(context).push(
    //                       MaterialPageRoute(
    //                         builder: (context) => ProductDetails(
    //                           productId: '${product.id}',
    //                           productImage: '${product.image}',
    //                           productCode: '${product.code}',
    //                           productName: '${product.name}',
    //                           productDescription: '${product.description}',
    //                           productPrice: '${product.price}',
    //                           productSize: '${product.size}',
    //                           productBrand: '${product.brand}',
    //                           productCountry: '${product.country}',
    //                           productSubcategoryId: '${product.subcategoryId}',
    //                         ),
    //                       ),
    //                     ),
    //                 borderRadius: BorderRadius.all(Radius.circular(20))),
    //           );
    //         }),
    //         // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    //         //   maxCrossAxisExtent: 200.0,
    //         //   )
    //         gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
    //           crossAxisCount: 2,
    //           childAspectRatio: MediaQuery.of(context).size.width /
    //               (MediaQuery.of(context).size.height / 1.5),
    //         ),
    //       );

    //       // GridView.builder(
    //       //   physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
    //       //   shrinkWrap: true,
    //       //     itemCount: snapshot.data.length,
    //       //     gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
    //       //       crossAxisCount: 2,
    //       //       childAspectRatio: MediaQuery.of(context).size.width /
    //       //           (MediaQuery.of(context).size.height / 1.5),
    //       //     ),
    //       //     itemBuilder: (BuildContext context, int index) {
    //       //       Product product = snapshot.data[index];
    //       //       return Container(
    //       //         decoration: BoxDecoration(
    //       //           color: LightColor.background,
    //       //           borderRadius: BorderRadius.all(Radius.circular(20)),
    //       //           boxShadow: <BoxShadow>[
    //       //             BoxShadow(
    //       //                 color: Color(0xfff8f8f8),
    //       //                 blurRadius: 15,
    //       //                 spreadRadius: 10),
    //       //           ],
    //       //         ),
    //       //         // margin: EdgeInsets.symmetric(vertical: !product.isSelected ? 20 : 0),
    //       //         margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    //       //         child: Container(
    //       //           padding: EdgeInsets.symmetric(horizontal: 5),
    //       //           child: Column(
    //       //             crossAxisAlignment: CrossAxisAlignment.center,
    //       //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       //             children: <Widget>[
    //       //               // SizedBox(height: product.isSelected ? 15 : 0),
    //       //               // SizedBox(height: 15),
    //       //               Stack(
    //       //                 alignment: Alignment.center,
    //       //                 children: <Widget>[
    //       //                   CircleAvatar(
    //       //                     radius: 40,
    //       //                     backgroundColor: LightColor.orange.withAlpha(40),
    //       //                   ),
    //       //                   // Text('http://127.0.0.1:8000/uploads/product_image/'+'${product.image}'),
    //       //                   // Image.asset(productImage)
    //       //                   // Image.network(
    //       //                   //     'http://192.168.65.1/martkh/assets/product_image/' +
    //       //                   //         '${product.image}'),
    //       //                   CachedNetworkImage(
    //       //                     imageUrl: "http://10.0.2.2:8000/uploads/product_image/${product.image}",
    //       //                     progressIndicatorBuilder:
    //       //                         (context, url, downloadProgress) =>
    //       //                             CircularProgressIndicator(
    //       //                                 value: downloadProgress.progress),
    //       //                     errorWidget: (context, url, error) =>
    //       //                         Icon(Icons.error),
    //       //                   ),
    //       //                   // Image(image:NetworkImageWithRetry('http://10.0.2.2:8000/uploads/product_image/'+'${product.image}')),

    //       //                   // Image.network('http://10.0.2.2:8000/uploads/product_image/'+'${product.image}'),
    //       //                 ],
    //       //               ),
    //       //               // SizedBox(height: 5),
    //       //               TitleText(
    //       //                 text: '${product.name}',
    //       //                 fontSize: 12,
    //       //               ),
    //       //               TitleText(
    //       //                 text: 'US \$' + '${product.price}',
    //       //                 fontSize: 14,
    //       //                 // color: Colors.red,
    //       //               ),
    //       //             ],
    //       //           ),
    //       //         ).ripple(
    //       //             // () {},
    //       //             () => Navigator.of(context).push(
    //       //                   MaterialPageRoute(
    //       //                     builder: (context) => ProductDetails(
    //       //                       productId: '${product.id}',
    //       //                       productImage: '${product.image}',
    //       //                       productCode: '${product.code}',
    //       //                       productName: '${product.name}',
    //       //                       productDescription: '${product.description}',
    //       //                       productPrice: '${product.price}',
    //       //                       productSize: '${product.size}',
    //       //                       productBrand: '${product.brand}',
    //       //                       productCountry: '${product.country}',
    //       //                       productSubcategoryId:
    //       //                           '${product.subcategoryId}',
    //       //                     ),
    //       //                   ),
    //       //                 ),
    //       //             borderRadius: BorderRadius.all(Radius.circular(20))),
    //       //       );
    //       //     });
    //     }
    //     return Center(child: CircularProgressIndicator());
    //   },
    // );

    
//   }
// }

// class Products extends StatefulWidget {
//   @override
//   _ProductsState createState() => _ProductsState();
// }

// class _ProductsState extends State<Products> {
//   var productList = [
//     {
//       "name": "Monster Energy Green 500ml",
//       "image": "assets/products/monster.jpg",
//       "price": 2.5,
//     },
//     {
//       "name": "Cote dore",
//       "image": "assets/products/cotedore.jpg",
//       "price": 1.5,
//     },
//     {
//       "name": "Coca Cola Vanilla 330ml",
//       "image": "assets/products/cocacola.jpg",
//       "price": 0.5,
//     },
//   ];
//   @override
//   Widget build(BuildContext context) {
//     // print(MediaQuery.of(context).size.width);
//     // print(MediaQuery.of(context).size.height);
//     return GridView.builder(
//       itemCount: productList.length,
//       gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: MediaQuery.of(context).size.width /
//               (MediaQuery.of(context).size.height/1.5),
//       ),
//       itemBuilder: (BuildContext context,int index){
//         // return Product(
//         //   productName: productList[index]['name'],
//         //   productImage: productList[index]['image'],
//         //   productPrice: productList[index]['price'],
//         // );
//         return Container(

//         );
//       }
//     );
//   }
// }

// class Product extends StatelessWidget {
//   final productName;
//   final productImage;
//   final productPrice;

//   const Product({Key key, this.productName, this.productImage, this.productPrice}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // height: 500,
//       decoration: BoxDecoration(
//         color: LightColor.background,
//         borderRadius: BorderRadius.all(Radius.circular(20)),
//         boxShadow: <BoxShadow>[
//           BoxShadow(color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
//         ],
//       ),
//       // margin: EdgeInsets.symmetric(vertical: !product.isSelected ? 20 : 0),
//       margin: EdgeInsets.symmetric(vertical:5,horizontal: 5),
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
//                 Image.asset(productImage)
//               ],
//             ),
//             // SizedBox(height: 5),
//             TitleText(
//               text: productName,
//               // fontSize: product.isSelected ? 16 : 14,
//               fontSize: 12,
//             ),
//             // TitleText(
//             //   text: product.category,
//             //   fontSize: product.isSelected ? 14 : 12,
//             //   color: LightColor.orange,
//             // ),
//             TitleText(
//               // text: "US \$" + productPrice.toString(),
//               text: "US \$$productPrice",
//               // fontSize: product.isSelected ? 18 : 16,
//               fontSize: 14,
//               // color: Colors.red,
//             ),
//             // Text(productName)
//           ],
//         ),
//       ).ripple(() {
//         // Navigator.of(context).pushNamed('/detail');
//         // onSelected(product);
//       }, borderRadius: BorderRadius.all(Radius.circular(20))),
//     );
//   }
// }

// class Product extends StatelessWidget {
//   final productName;
//   final productImage;
//   final productPrice;
//   final productCode;
//   final productDescription;
//   final productSize;
//   final productBrand;
//   final productCountry;
//   final productSubcategoryID;
//   final productCreatedDate;
//   final productUpdatedDate;

//   const Product({Key key, this.productName, this.productImage, this.productPrice, this.productCode, this.productDescription, this.productSize, this.productBrand, this.productCountry, this.productSubcategoryID, this.productCreatedDate, this.productUpdatedDate}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // height: 500,
//       decoration: BoxDecoration(
//         color: LightColor.background,
//         borderRadius: BorderRadius.all(Radius.circular(20)),
//         boxShadow: <BoxShadow>[
//           BoxShadow(color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
//         ],
//       ),
//       // margin: EdgeInsets.symmetric(vertical: !product.isSelected ? 20 : 0),
//       margin: EdgeInsets.symmetric(vertical:5,horizontal: 5),
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
//                 Image.asset(productImage)
//               ],
//             ),
//             // SizedBox(height: 5),
//             TitleText(
//               text: productName,
//               // fontSize: product.isSelected ? 16 : 14,
//               fontSize: 12,
//             ),
//             // TitleText(
//             //   text: product.category,
//             //   fontSize: product.isSelected ? 14 : 12,
//             //   color: LightColor.orange,
//             // ),
//             TitleText(
//               // text: "US \$" + productPrice.toString(),
//               text: "US \$$productPrice",
//               // fontSize: product.isSelected ? 18 : 16,
//               fontSize: 14,
//               // color: Colors.red,
//             ),
//             // Text(productName)
//           ],
//         ),
//       ).ripple(() {
//         // Navigator.of(context).pushNamed('/detail');
//         // onSelected(product);
//       }, borderRadius: BorderRadius.all(Radius.circular(20))),
//     );
//   }
// }
