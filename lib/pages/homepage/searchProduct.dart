import 'package:flutter/material.dart';
import 'package:martkh/services/product-api.dart';
import 'package:martkh/pages/homepage/productPage.dart';
import 'package:martkh/pages/homepage/product_details.dart';
import 'package:martkh/models/productlist.dart';
import 'package:martkh/models/products.dart';
import 'package:async/async.dart';

class SearchProduct extends SearchDelegate<Product> {
  @override
  String get searchFieldLabel => 'Search';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          }),
      // ClipOval(
      //   child: Material(
      //     color: Colors.white, // button color
      //     child: InkWell(
      //       splashColor: Colors.red, // inkwell color
      //       child: SizedBox(width: 56, height: 56, child: Icon(Icons.search)),
      //       onTap: () {
      //         buildResults(context);
      //       },
      //     ),
      //   ),
      // )
    ];
    // throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
    // throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    return query.isEmpty
        ? Center(child: Text("Input a product name to search"))
        : FutureBuilder<ProductList>(
            future: Products.searchProduct(query, 1),
            builder: (context, snapshots) {
              if (snapshots.hasError) return Text("Error Occurred");
              switch (snapshots.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());

                case ConnectionState.done:
                  return SearchProductTile(
                      keyword: query, products: snapshots.data);
                default:
                return Center(child: CircularProgressIndicator());

              }
            });
    // Center(
    //   child: Text(query),
    // );
    // return Container(
    //   height: 100,
    //   width: 100,
    //   child: Card(
    //     color: Colors.red,
    //     // shape: StadiumBorder(),
    //     child: Center(
    //       child: Text(query),

    //       ),
    //   ),
    // );
    // throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: Products.fetchProductList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Product> productlist = snapshot.data;
            // map.entries.forEach((e) => productlist.add(Product(e.key, e.value)));
            // print(productlist);
            // print(snapshot.data[0].name);
            final list = query.isEmpty
                ? productlist
                : productlist
                    .where((p) =>
                        p.name.toLowerCase().startsWith(query.toLowerCase()))
                    .toList();
            return list.isEmpty
                ? Center(child: Text('No Suggestion Available'))
                // ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      // return Text(snapshot.data[index].name);
                      return ListTile(
                        onTap: () {
                          // showResults(context);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetails(pid: list[index].id),
                            ),
                          );
                        },
                        leading: Icon(Icons.fastfood),
                        // title: Text(list[index].name),
                        title: RichText(
                          text: TextSpan(
                              text: list[index].name
                                  .substring(0, query.length),
                              style: TextStyle(
                                  fontSize:18,
                                  color: Colors.black,
                                  // fontWeight: FontWeight.bold
                              ),
                              children: [
                                TextSpan(
                                  text: list[index].name
                                      .substring(query.length),
                                  style: TextStyle(color: Colors.grey),
                                )
                              ]),
                        ),
                      );
                    });
            //   // print(snapshot.data.map((product)=>product.name).toList());
            //   List<dynamic> list = snapshot.data.map((product)=>product.name).toList();
            //   // print(list);
            //   // print(list.where((p)=>p.startsWith('Monster')));
            //   var productList = query.isEmpty? list: list.where((p)=>p.startsWith(query));
            //   // final productList = query.isEmpty? snapshot.data : snapshot.data.where((p)=>p.name.startsWith(query)).toList();
            //   // return productList.isEmpty? Text('noresult'):
            // //   final productList = query.isEmpty
            // // ? snapshot.data.name
            // // : snapshot.data.where((p) => p.name.startsWith(query)).toList();
            //   return productList.isEmpty? Text('No result'):
            // ListView.builder(
            //     itemCount: snapshot.data.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       Product product = snapshot.data[index];
            //       // print(product.name);
            //       // final productList = query.isEmpty? product : snapshot.data.where((p)=>p.name.startsWith(query)).toList();
            //       return ListTile(
            //         onTap: (){
            //           showResults(context);
            //         },
            //         title : Text(productList.toString()),
            //       );
            //     }
            // );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });

    // return Center(child: CircularProgressIndicator());

    // return ListView.builder(
    //   itemCount: productList.length,
    //   itemBuilder: (context,index){
    //     final Products product = productList[index];
    //     return ListTile(
    //       title : Text(product.name);
    //     )
    //   },
    // );

    // final suggestionList = query.isEmpty
    //     ? recentProducts
    //     : products.where((p) => p.startsWith(query)).toList();

    // return ListView.builder(
    //   itemBuilder: (context, index) => ListTile(
    //     onTap: () {
    //       showResults(context);
    //     },
    //     leading: Icon(Icons.fastfood),
    //     // title: Text(suggestionList[index]),
    //     title: RichText(
    //       text: TextSpan(
    //           text: suggestionList[index].substring(0, query.length),
    //           style:
    //               TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    //           children: [
    //             TextSpan(
    //               text: suggestionList[index].substring(query.length),
    //               style: TextStyle(color: Colors.grey),
    //             )
    //           ]),
    //     ),
    //   ),
    //   itemCount: suggestionList.length,
    // );
    // throw UnimplementedError();
  }
}

class SearchProductTile extends StatefulWidget {
  final ProductList products;
  final keyword;

  SearchProductTile({Key key, this.keyword, this.products}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SearchProductTileState();
}

class SearchProductTileState extends State<SearchProductTile> {
  ProductLoadMoreStatus loadMoreStatus = ProductLoadMoreStatus.STABLE;
  final ScrollController scrollController = ScrollController();
  List<Product> products;
  int currentPageNumber;
  CancelableOperation productOperation;
  // bool _isEndofPage = false;

  @override
  void initState() {
    products = widget.products.products;
    currentPageNumber = widget.products.page;
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    if (productOperation != null) productOperation.cancel();
    super.dispose();
  }

  bool onNotification(ScrollNotification notification) {
    // if (notification is ScrollUpdateNotification) {
    if (notification is ScrollEndNotification) {
      // if (scrollController.position.maxScrollExtent > scrollController.offset &&
      //     scrollController.position.maxScrollExtent - scrollController.offset <= 50) {
      // if(scrollController.offset >= scrollController.position.maxScrollExtent &&
      // !scrollController.position.outOfRange){
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (loadMoreStatus != null &&
            loadMoreStatus == ProductLoadMoreStatus.STABLE) {
          loadMoreStatus = ProductLoadMoreStatus.LOADING;
          productOperation = CancelableOperation.fromFuture(
              Products.searchProduct(widget.keyword, currentPageNumber + 1)
                  .then((productsObject) {
            currentPageNumber = productsObject.page;
            loadMoreStatus = ProductLoadMoreStatus.STABLE;
            setState(() => products.addAll(productsObject.products));
            print(scrollController.offset);
            // if(currentPageNumber==productsObject.totalPages){
            //   print("nth to load");
            //   setState(() {
            //     _isEndofPage = true;
            //   });
            // }
          }));
        }
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // final l = products.length;
    return NotificationListener(
      onNotification: onNotification,
      child:
          // SliverGrid(
          //   delegate: SliverChildBuilderDelegate(
          //     (BuildContext context, int index) {
          //       // Product product = snapshot.data[index];
          //       return ProductListTile(product: products[index]);
          //     },
          //     childCount: products.length,
          //   ),
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //     childAspectRatio: MediaQuery.of(context).size.width /
          //         (MediaQuery.of(context).size.height / 1.5),
          //   ),
          // ),

          GridView.builder(
        // scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.only(
          top: 5.0,
        ),
        // EdgeInsets.only
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
        ),
        controller: scrollController,
        itemCount: products.length,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return ProductListTile(product: products[index]);
        },
      ),
    );
  }
}
