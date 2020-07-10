import 'dart:convert';

List<Category> categoryFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
    Category({
        this.id,
        this.categoriesName,
    });

    int id;
    String categoriesName;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        categoriesName: json["categories_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "categories_name": categoriesName,
    };
}
