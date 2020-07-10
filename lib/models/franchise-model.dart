import 'dart:convert';

List<Franchise> franchiseFromJson(String str) => List<Franchise>.from(json.decode(str).map((x) => Franchise.fromJson(x)));

String franchiseToJson(List<Franchise> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Franchise {
    Franchise({
        this.id,
        this.franchiseName,
        this.address,
        this.lat,
        this.lng,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String franchiseName;
    String address;
    dynamic lat;
    dynamic lng;
    DateTime createdAt;
    DateTime updatedAt;

    factory Franchise.fromJson(Map<String, dynamic> json) => Franchise(
        id: json["id"],
        franchiseName: json["franchise_name"],
        address: json["address"],
        lat: json["lat"],
        lng: json["lng"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "franchise_name": franchiseName,
        "address": address,
        "lat": lat,
        "lng": lng,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}