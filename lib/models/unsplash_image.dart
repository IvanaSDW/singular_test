import 'package:singular_test/models/unsplash_user.dart';

class UnsplashImage {
  UnsplashImage({required this.id,
    required this.regularUrl,
    required this.fullUrl,
    required this.width,
    required this.height,
    required this.altDescription,
    required this.description,
    required this.exif,
    required this.likes,
    required this.rawUrl,
    required this.smallUrl,
    required this.thumbUrl,
    required this.author});

  String id;
  String? description;
  String? altDescription;
  UnsplashUser author;
  String rawUrl;
  String thumbUrl;
  String smallUrl;
  String regularUrl;
  String fullUrl;
  int height;
  int width;
  int likes;
  Map<dynamic, dynamic>? exif;

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'regularUrl': regularUrl,
        'fullUrl': fullUrl,
        'width': width,
        'height': height,
        'altDescription': altDescription,
        'description': description,
        //exif: {},
        'likes': likes,
        'rawUrl': rawUrl,
        'smallUrl': smallUrl,
        'thumbUrl': thumbUrl,
        'author': author.toJson(),
      };

  factory UnsplashImage.fromJson(Map<String, dynamic> json) =>
      UnsplashImage(
        id: json['id'],
        regularUrl: json['urls']['regular'],
        fullUrl: json['urls']['full'],
        width: json['width'],
        height: json['height'],
        altDescription: json['alt_description'],
        description: json['description'],
        exif: {},
        likes: json['likes'],
        rawUrl: json['urls']['raw'],
        smallUrl: json['urls']['small'],
        thumbUrl: json['urls']['thumb'],
        author: UnsplashUser.fromJson(json['user']),
      );

  factory UnsplashImage.fromFirebase(Map<String, dynamic> json) =>
      UnsplashImage(
        id: json['id'],
        regularUrl: json['regularUrl'],
        fullUrl: json['fullUrl'],
        width: json['width'],
        height: json['height'],
        altDescription: json['alt_description'],
        description: json['description'],
        exif: {},
        likes: json['likes'],
        rawUrl: json['rawUrl'],
        smallUrl: json['smallUrl'],
        thumbUrl: json['thumbUrl'],
        author: UnsplashUser.fromFirebase(json['author']),
      );

// Exif getExif() {
//   return data['exif'] != null ? Exif(data['exif']) : null;
// }
}
