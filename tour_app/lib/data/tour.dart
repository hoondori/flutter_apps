import 'package:firebase_database/firebase_database.dart';

class TourData {
  String? title;
  String? tel;
  String? zipcode;
  String? address;

  var id;
  var mapx;
  var mapy;
  String? imagePath;

  TourData(this.id, this.title, this.tel, this.zipcode, this.address, this.mapx, this.mapy, this.imagePath);

  TourData.fromJson(Map data) {
    id = data['id'] ?? 'No id';
    title = data['title'] ?? 'No title';
    tel = data['tel'] ?? 'No tel';
    zipcode = data['zipcode'] ?? 'No zipcode';
    address = data['address'] ?? 'No address';
    mapx = data['mapx'] ?? 'No mapx';
    mapy = data['mapy'] ?? 'No mapy';
    imagePath = data['firstimage'] ?? null;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'tel': tel,
      'zipcode': zipcode,
      'address': address,
      'mapx': mapx,
      'mapy': mapy,
      'imagePath': imagePath
    };
  }
}