import 'package:singular_test/models/unsplash_user.dart';

class UnsplashImage {
  UnsplashImage({required this.id,
    required this.regularUrl,
    required this.fullUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.width,
    required this.height,
    required this.altDescription,
    required this.description,
    required this.exif,
    required this.likes,
    required this.rawUrl,
    required this.smallUrl,
    required this.thumbUrl,
    required this.user});

  String id;
  String? description;
  String? altDescription;
  UnsplashUser user;
  String rawUrl;
  String thumbUrl;
  String smallUrl;
  String regularUrl;
  String fullUrl;
  int height;
  int width;
  int likes;
  DateTime createdAt;
  DateTime updatedAt;
  Map<dynamic, dynamic>? exif;

  Map<String, dynamic> toJson(UnsplashImage image) =>
      {
        'id': image.id,
        'regularUrl': image.regularUrl,
        'fullUrl': image.fullUrl,
        'createdAt': image.createdAt,
        'updatedAt': image.updatedAt,
        'width': image.width,
        'height': image.height,
        'altDescription': image.altDescription,
        'description': image.description,
        //exif: {},
        'likes': image.likes,
        'rawUrl': image.rawUrl,
        'smallUrl': image.smallUrl,
        'thumbUrl': image.thumbUrl,
        'user': image.user.toJson(),
      };

  factory UnsplashImage.fromJson(Map<String, dynamic> json) =>
      UnsplashImage(
        id: json['id'],
        regularUrl: json['urls']['regular'],
        fullUrl: json['urls']['full'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        width: json['width'],
        height: json['height'],
        altDescription: json['alt_description'],
        description: json['description'],
        exif: {},
        likes: json['likes'],
        rawUrl: json['urls']['raw'],
        smallUrl: json['urls']['small'],
        thumbUrl: json['urls']['thumb'],
        user: UnsplashUser.fromJson(json['user']),
      );

// Exif getExif() {
//   return data['exif'] != null ? Exif(data['exif']) : null;
// }
}
