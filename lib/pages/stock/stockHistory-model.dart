import 'dart:convert';

List<StockFranchiseHistory> stockFranchiseHistoryFromJson(String str) => List<StockFranchiseHistory>.from(json.decode(str).map((x) => StockFranchiseHistory.fromJson(x)));

String stockFranchiseHistoryToJson(List<StockFranchiseHistory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StockFranchiseHistory {
    StockFranchiseHistory({
        this.id,
        this.franchiseId,
        this.productId,
        this.status,
        this.amount,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.image,
    });

    int id;
    int franchiseId;
    int productId;
    String status;
    int amount;
    DateTime createdAt;
    DateTime updatedAt;
    String name;
    String image;

    factory StockFranchiseHistory.fromJson(Map<String, dynamic> json) => StockFranchiseHistory(
        id: json["id"],
        franchiseId: json["franchise_id"],
        productId: json["product_id"],
        status: json["status"],
        amount: json["amount"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "franchise_id": franchiseId,
        "product_id": productId,
        "status": status,
        "amount": amount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
        "image": image,
    };
}
