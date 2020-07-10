// import 'dart:convert';

// List<Ads> adsFromJson(String str) => List<Ads>.from(json.decode(str).map((x) => Ads.fromJson(x)));

// String adsToJson(List<Ads> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Ads {
//     Ads({
//         this.id,
//         this.image,
//     });

//     int id;
//     String image;

//     factory Ads.fromJson(Map<String, dynamic> json) => Ads(
//         id: json["id"],
//         image: json["image"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "image": image,
//     };
// }
class Ads {
  int id;
  String image;

  Ads({this.id, this.image});

  Ads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}
