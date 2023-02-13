import 'package:singular_test/models/unsplash_user.dart';

class UnsplashImage {
  UnsplashImage({required this.id,
    required this.regularUrl,
    required this.fullUrl,
    required this.width,
    required this.height,
    required this.altDescription,
    required this.description,
    required this.likes,
    required this.downloads,
    required this.views,
    required this.topics,
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
  int? downloads;
  int? views;
  List<dynamic>? topics;
  Map<dynamic, dynamic>? exif;

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'description': description,
        'altDescription': altDescription,
        'author': author.toJson(),
        'rawUrl': rawUrl,
        'thumbUrl': thumbUrl,
        'smallUrl': smallUrl,
        'regularUrl': regularUrl,
        'fullUrl': fullUrl,
        'height': height,
        'width': width,
        'likes': likes,
        'downloads': downloads,
        'views': views,
        'topics': topics,
      };

  factory UnsplashImage.fromJson(Map<String, dynamic> json) =>
      UnsplashImage(
        id: json['id'],
        description: json['description'],
        altDescription: json['alt_description'],
        author: UnsplashUser.fromJson(json['user']),
        rawUrl: json['urls']['raw'],
        thumbUrl: json['urls']['thumb'],
        smallUrl: json['urls']['small'],
        regularUrl: json['urls']['regular'],
        fullUrl: json['urls']['full'],
        height: json['height'],
        width: json['width'],
        likes: json['likes'],
        downloads: json['downloads'],
        views: json['views'],
        topics: json['topic_submissions'].keys.toList(),
      );

  factory UnsplashImage.fromFirebase(Map<String, dynamic> json) =>
      UnsplashImage(
        id: json['id'],
        description: json['description'],
        altDescription: json['altDescription'],
        author: UnsplashUser.fromFirebase(json['author']),
        rawUrl: json['rawUrl'],
        thumbUrl: json['thumbUrl'],
        smallUrl: json['smallUrl'],
        regularUrl: json['regularUrl'],
        fullUrl: json['fullUrl'],
        height: json['height'],
        width: json['width'],
        likes: json['likes'],
        downloads: json['downloads'],
        views: json['views'],
        topics: json['topics'],
      );

}
