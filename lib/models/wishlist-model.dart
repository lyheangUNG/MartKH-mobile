//1
// import 'dart:convert';

// List<WishList> wishListFromJson(String str) => List<WishList>.from(json.decode(str).map((x) => WishList.fromJson(x)));

// String wishListToJson(List<WishList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class WishList {
//     WishList({
//         this.id,
//         this.userId,
//         this.wishlistId,
//         // this.createdAt,
//         // this.updatedAt,
//     });

//     int id;
//     int userId;
//     int wishlistId;
//     // DateTime createdAt;
//     // dynamic updatedAt;

//     factory WishList.fromJson(Map<String, dynamic> json) => WishList(
//         id: json["id"],
//         userId: json["user_id"],
//         wishlistId: json["wishlist_id"],
//         // createdAt: DateTime.parse(json["created_at"]),
//         // updatedAt: json["updated_at"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "wishlist_id": wishlistId,
//         // "created_at": createdAt.toIso8601String(),
//         // "updated_at": updatedAt,
//     };
// }

//2
// import 'dart:convert';

// List<WishList> wishListFromJson(String str) => List<WishList>.from(json.decode(str).map((x) => WishList.fromJson(x)));

// String wishListToJson(List<WishList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class WishList {
//     WishList({
//         this.id,
//         this.image,
//         // this.code,
//         this.name,
//         // this.description,
//         // this.price,
//         // this.size,
//         // this.brand,
//         // this.country,
//         // this.subcategoryId,
//         // this.view,
//         // this.createdAt,
//         // this.updatedAt,
//         this.userId,
//         this.wishlistId,
//         // this.email,
//         // this.emailVerifiedAt,
//         // this.password,
//         // this.rememberToken,
//         // this.role,
//         // this.avatar,
//         // this.providerId,
//         // this.provider,
//     });

//     int id;
//     String image;
//     // String code;
//     String name;
//     // String description;
//     // double price;
//     // String size;
//     // String brand;
//     // String country;
//     // int subcategoryId;
//     // dynamic view;
//     // DateTime createdAt;
//     // DateTime updatedAt;
//     int userId;
//     int wishlistId;
//     // String email;
//     // dynamic emailVerifiedAt;
//     // String password;
//     // String rememberToken;
//     // String role;
//     // String avatar;
//     // dynamic providerId;
//     // dynamic provider;

//     factory WishList.fromJson(Map<String, dynamic> json) => WishList(
//         id: json["id"],
//         image: json["image"],
//         // code: json["code"],
//         name: json["name"],
//         // description: json["description"],
//         // price: json["price"].toDouble(),
//         // size: json["size"],
//         // brand: json["brand"],
//         // country: json["country"],
//         // subcategoryId: json["subcategory_id"],
//         // view: json["view"],
//         // createdAt: DateTime.parse(json["created_at"]),
//         // updatedAt: DateTime.parse(json["updated_at"]),
//         userId: json["user_id"],
//         wishlistId: json["wishlist_id"],
//         // email: json["email"],
//         // emailVerifiedAt: json["email_verified_at"],
//         // password: json["password"],
//         // rememberToken: json["remember_token"],
//         // role: json["role"],
//         // avatar: json["avatar"],
//         // providerId: json["provider_id"],
//         // provider: json["provider"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "image": image,
//         // "code": code,
//         "name": name,
//         // "description": description,
//         // "price": price,
//         // "size": size,
//         // "brand": brand,
//         // "country": country,
//         // "subcategory_id": subcategoryId,
//         // "view": view,
//         // "created_at": createdAt.toIso8601String(),
//         // "updated_at": updatedAt.toIso8601String(),
//         "user_id": userId,
//         "wishlist_id": wishlistId,
//         // "email": email,
//         // "email_verified_at": emailVerifiedAt,
//         // "password": password,
//         // "remember_token": rememberToken,
//         // "role": role,
//         // "avatar": avatar,
//         // "provider_id": providerId,
//         // "provider": provider,
//     };
// }

import 'dart:convert';

List<WishList> wishListFromJson(String str) => List<WishList>.from(json.decode(str).map((x) => WishList.fromJson(x)));

String wishListToJson(List<WishList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WishList {
    WishList({
        this.pid,
        this.image,
        this.pName,
        this.uid,
        this.wid,
    });

    int pid;
    String image;
    String pName;
    int uid;
    int wid;

    factory WishList.fromJson(Map<String, dynamic> json) => WishList(
        pid: json["pid"],
        image: json["image"],
        pName: json["pName"],
        uid: json["uid"],
        wid: json["wid"],
    );

    Map<String, dynamic> toJson() => {
        "pid": pid,
        "image": image,
        "pName": pName,
        "uid": uid,
        "wid": wid,
    };
}
