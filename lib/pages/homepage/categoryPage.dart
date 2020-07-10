import 'package:flutter/material.dart';
import 'package:martkh/pages/homepage/subcategoryPage.dart';

import '../../services/category-api.dart';
import '../../models/category-model.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.symmetric(horizontal: 12),
        margin: EdgeInsets.only(left: 12),
        height: 140.0,
        child: FutureBuilder(
            future: Categories().fetchCategories(),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text("Error Occurred");
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());

                case ConnectionState.done:
                  return CategoryTile(categories: snapshot.data);
                default:
                return Center(child: CircularProgressIndicator());
              }
            })
        // ListView(
        //   scrollDirection: Axis.horizontal,
        //   children: <Widget>[
        //     Categories(
        //       imageLocation: 'assets/categories/beverages.png',
        //       category: 'Beverages',
        //     ),
        //     Categories(
        //       imageLocation: 'assets/categories/dairy.png',
        //       category: 'Dairy',
        //     ),
        //     Categories(
        //       imageLocation: 'assets/categories/fruits.png',
        //       category: 'Fruit & Vegetable',
        //     ),
        //     Categories(
        //       imageLocation: 'assets/categories/meats.png',
        //       category: 'Meats',
        //     ),
        //     Categories(
        //       imageLocation: 'assets/categories/foods.png',
        //       category: 'Foods',
        //     ),
        //   ],
        // ),
        );
  }
}

class CategoryTile extends StatelessWidget {
  final categories;
  
  const CategoryTile({Key key, this.categories}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<String> image = [
      'assets/categories/beverages.png',
      'assets/categories/dairy.png',
      'assets/categories/foods.png',
      'assets/categories/fruits.png',
      'assets/categories/meats.png',
    ];
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context,index){
        return CategoryListTile(category: categories[index],image:image[index]);
      },
    );
  }
}

class CategoryListTile extends StatelessWidget {
  // final String imageLocation;
  final Category category;
  final String image;
  // const CategoryListTile({Key key, this.imageLocation, this.category})
  const CategoryListTile({Key key, this.category, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SubcategoryList(
                cid: category.id
                // pid: '${snapshot.data[index].pid}',
              ),
            ),
          );
        },
        child: Container(
          width: 120.0,
          child: ListTile(
            // title: Image.asset(imageLocation),
            title: Image.asset(image),
            subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  category.categoriesName,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
