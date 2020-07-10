// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:martkh/pages/homepage/appbar.dart';
// import 'package:martkh/pages/homepage/homepage.dart';
import 'package:martkh/services/product-api.dart';
import 'package:martkh/pages/homepage/productPage.dart';
// import 'package:martkh/pages/homepage/product_details.dart';
import 'package:martkh/models/productlist.dart';
import 'package:martkh/models/products.dart';
import 'package:martkh/pages/homepage/searchProduct.dart';
// import 'package:martkh/themes/light_color.dart';
// import 'package:martkh/themes/title_text.dart';
import 'package:flutter/foundation.dart';
import 'package:async/async.dart';
// import 'package:martkh/themes/extensions.dart';

enum ProductSubcategoryLoadMoreStatus { LOADING, STABLE }

class ProductPageSubcategory extends StatelessWidget {
  final sid;
  final sName;

  const ProductPageSubcategory({Key key, this.sid, this.sName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: ProductsubcategoryAppBar(title:sName),
          body: FutureBuilder<ProductList>(
          future: Products.fetchProductSubcategory(sid, 1),
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            if (snapshots.hasError) return Text("Error Occurred");
            // switch (snapshots.connectionState) {
            //   case ConnectionState.waiting:
            //     return Center(child: CircularProgressIndicator());

            //   case ConnectionState.done:
            //     return ProductSubcategoryTile(sid:sid,products: snapshots.data);
            //   default:
            // }
            if(snapshots.hasData){
                return ProductSubcategoryTile(sid:sid,products: snapshots.data);
            }
            else{
              return Center(child: CircularProgressIndicator(),);
            }
          }),
    );
  }
}

class ProductSubcategoryTile extends StatefulWidget {
  final ProductList products;
  final sid;

  ProductSubcategoryTile({Key key,this.sid, this.products}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProductSubcategoryTileState();
}

class ProductSubcategoryTileState extends State<ProductSubcategoryTile> {
  ProductSubcategoryLoadMoreStatus loadMoreStatus = ProductSubcategoryLoadMoreStatus.STABLE;
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
            loadMoreStatus == ProductSubcategoryLoadMoreStatus.STABLE) {
          loadMoreStatus = ProductSubcategoryLoadMoreStatus.LOADING;
          productOperation = CancelableOperation.fromFuture(
              Products.fetchProductSubcategory(widget.sid,currentPageNumber + 1)
                  .then((productsObject) {
            currentPageNumber = productsObject.page;
            loadMoreStatus = ProductSubcategoryLoadMoreStatus.STABLE;
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

class ProductsubcategoryAppBar extends StatelessWidget with PreferredSizeWidget {
  final double appBarHeight = 70.0;
  final title;

  ProductsubcategoryAppBar({Key key, this.title}) : super(key: key);
  @override
  get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    final double horizontalMargin = 5;
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
                        child:
                            Icon(Icons.arrow_back, color: Colors.white, size: 30),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        // showSearch(context: context, delegate: SearchProduct());
                      },
                    ),
                //   ),
                // ),
              ),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
                child: ClipOval(
                  child: Material(
                    color: Colors.grey.withOpacity(0.2), // button color
                    child: InkWell(
                      splashColor: Colors.red, // inkwell color
                      child: SizedBox(
                        width: 56,
                        height: 56,
                        child:
                            Icon(Icons.search, color: Colors.white, size: 30),
                      ),
                      onTap: () {
                        showSearch(context: context, delegate: SearchProduct());
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