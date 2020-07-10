import 'dart:convert';

List<StockFranchise> stockFranchiseFromJson(String str) => List<StockFranchise>.from(json.decode(str).map((x) => StockFranchise.fromJson(x)));

String stockFranchiseToJson(List<StockFranchise> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StockFranchise {
    StockFranchise({
        this.amount,
        this.productId,
        this.franchiseId,
        // this.createdAt,
        // this.updatedAt,
        this.sfCreated,
        this.sfid,
        this.image,
        // this.code,
        this.name,
        // this.description,
        this.price,
        // this.size,
        // this.brand,
        // this.country,
        this.subcategoryId,
        this.view,
        this.franchiseName,
        this.address,
    });

    int amount;
    int productId;
    int franchiseId;
    // DateTime createdAt;
    // DateTime updatedAt;
    DateTime sfCreated;
    int sfid;
    String image;
    // String code;
    String name;
    // String description;
    double price;
    // String size;
    // String brand;
    // String country;
    int subcategoryId;
    dynamic view;
    String franchiseName;
    String address;

    factory StockFranchise.fromJson(Map<String, dynamic> json) => StockFranchise(
        amount: json["amount"],
        productId: json["product_id"],
        franchiseId: json["franchise_id"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        sfCreated: DateTime.parse(json["sf_created"]),
        sfid: json["sfid"],
        image: json["image"],
        // code: json["code"],
        name: json["name"],
        // description: json["description"],
        price: json["price"].toDouble(),
        // size: json["size"],
        // brand: json["brand"],
        // country: json["country"],
        subcategoryId: json["subcategory_id"],
        view: json["view"],
        franchiseName: json["franchise_name"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "product_id": productId,
        "franchise_id": franchiseId,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        "sf_created": sfCreated.toIso8601String(),
        "sfid": sfid,
        "image": image,
        // "code": code,
        "name": name,
        // "description": description,
        "price": price,
        // "size": size,
        // "brand": brand,
        // "country": country,
        "subcategory_id": subcategoryId,
        "view": view,
        "franchise_name": franchiseName,
        "address": address,
    };
}
