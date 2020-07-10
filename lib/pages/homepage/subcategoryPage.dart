import 'package:flutter/material.dart';
// import 'package:martkh/pages/homepage/appbar.dart';
// import 'package:martkh/pages/homepage/homepage.dart';
// import 'package:martkh/pages/homepage/productPage.dart';
import 'package:martkh/pages/homepage/productSubcategory.dart';
import 'package:martkh/services/subcategory-api.dart';

class SubcategoryList extends StatelessWidget {
  final cid;
  const SubcategoryList({Key key, this.cid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SubcategoryAppBar(title:"Subcategory"),
        body: Container(
        // height: 300,
        // boxcontr
        // constraints: BoxConstraints(maxWidth:500),
        child: FutureBuilder(
            future: Subcategories().fetchSubcategories(cid),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text("Error Occurred");
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());

                case ConnectionState.done:
                  return SubcategoryTile(subcategories: snapshot.data);
                default:
                return Center(child: CircularProgressIndicator());

              }
            }),
      ),
    );
  }
}

class SubcategoryTile extends StatelessWidget {
  final subcategories;

  const SubcategoryTile({Key key, this.subcategories}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: subcategories.length,
      itemBuilder: (context, index) {
        return SubcategoryListTile(subcategory: subcategories[index]);
      },
    );
  }
}

class SubcategoryListTile extends StatelessWidget {
  final subcategory;

  const SubcategoryListTile({Key key, this.subcategory}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return 
    // Padding(
    //   padding: EdgeInsets.all(2.0),
    //   child: InkWell(
    //     // onTap: () {
    //     //   Navigator.of(context).push(
    //     //     MaterialPageRoute(
    //     //       builder: (context) => SubcategoryList(
    //     //         cid: category.id
    //     //         // pid: '${snapshot.data[index].pid}',
    //     //       ),
    //     //     ),
    //     //   );
    //     // },
    //     child: Container(
    //       width: 120.0,
    //       child: ListTile(
    //         // title: Image.asset(imageLocation),
    //         title: Image.asset('assets/categories/beverages.png'),
    //         subtitle: Container(
    //             alignment: Alignment.topCenter,
    //             child: Text(
    //               subcategory.subcategoryName,
    //               style: TextStyle(
    //                 fontWeight: FontWeight.w500,
    //                 fontSize: 14,
    //               ),
    //             )),
    //       ),
    //     ),
    //   ),
    // );

    Container(
      // height: 80.0,
      child: Card(
        child: ListTile(
          leading: Image.asset('assets/categories/beverages.png'),
            // Container(
            //   padding: EdgeInsets.only(top: 10.0),
            //   child: CachedNetworkImage(
            //     imageUrl:
            //         // "http://10.0.2.2:8000/uploads/product_image/${snapshot.data[index].image}",
            //         "http://192.168.31.58:8000/uploads/product_image/${snapshot.data[index].image}",
            //     progressIndicatorBuilder: (context, url, downloadProgress) =>
            //         CircularProgressIndicator(value: downloadProgress.progress),
            //     errorWidget: (context, url, error) => Icon(Icons.error),
            //   ),
            // ),
          title: Text(subcategory.subcategoryName),
          // subtitle: Text(''),
          trailing: InkWell(
            splashColor: Colors.white,
            child: Icon(Icons.navigate_next),
            // onTap: () {
            //   // removeFromWishList('${snapshot.data[index].pid}');
            // },
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductPageSubcategory(
                  sid: subcategory.id,
                  sName: subcategory.subcategoryName
                  // pid: '${snapshot.data[index].pid}',
                ),
              ),
            );
          },
          // isThreeLine: true,
        ),
      ),
    );
  }
}

class SubcategoryAppBar extends StatelessWidget with PreferredSizeWidget {
  final double appBarHeight = 70.0;
  final title;

  SubcategoryAppBar({Key key, this.title}) : super(key: key);
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
            // actions: <Widget>[
              
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
              //   child: ClipOval(
              //     child: Material(
              //       color: Colors.grey.withOpacity(0.2), // button color
              //       child: InkWell(
              //         splashColor: Colors.red, // inkwell color
              //         child: SizedBox(
              //             width: 56,
              //             height: 56,
              //             child: Icon(
              //               Icons.shopping_cart,
              //               color: Colors.white,
              //             )),
              //         onTap: () {},
              //       ),
              //     ),
              //   ),
              // ),
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