import 'package:flutter/material.dart';
import 'package:martkh/pages/homepage/searchProduct.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final double appBarHeight = 70.0;
  final title;

  MyAppBar({Key key, this.title}) : super(key: key);
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
                Padding(
                  padding: EdgeInsets.all(35),
                  child: Text(
                    // "MartKH",
                    title,
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