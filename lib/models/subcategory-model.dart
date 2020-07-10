import 'dart:convert';

List<Subcategory> subcategoryFromJson(String str) => List<Subcategory>.from(json.decode(str).map((x) => Subcategory.fromJson(x)));

String subcategoryToJson(List<Subcategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Subcategory {
    Subcategory({
        this.id,
        this.categoryId,
        this.subcategoryName,
    });

    int id;
    int categoryId;
    String subcategoryName;

    factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json["id"],
        categoryId: json["category_id"],
        subcategoryName: json["subcategory_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "subcategory_name": subcategoryName,
    };
}
