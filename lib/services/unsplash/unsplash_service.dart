import 'dart:convert';
import 'dart:io';
import 'package:singular_test/config/keys.dart';
import '../../models/unsplash_image.dart';
import '../../utils/constants.dart';

class Unsplash {

  static const String baseUrl = 'https://api.unsplash.com';

  HttpClient httpClient = HttpClient();

  Future<List<UnsplashImage>> fetchImages(
      {int page = 1, int perPage = 10, String? keyword}) async {
    String url = '$baseUrl/photos?page=$page&per_page=$perPage&order_by=popular';

    var data = await _getImageData(url);

    List<UnsplashImage> images = List<UnsplashImage>.generate(data.length, (index) {
      return UnsplashImage.fromJson(data[index]);
    });
    return images;
  }

  Future<Map<String, dynamic>> fetchImagesByKeyword(
      {int page = 1, int perPage = 10, String? keyword}) async {
    String url = '$baseUrl/search/photos?query=$keyword&page=$page&per_page=$perPage&order_by=popular';


    var data = await _getImageData(url);

    List<UnsplashImage> images = data['results'].length == 0 ? [] : List<UnsplashImage>.generate(data['results'].length, (index) {
      return UnsplashImage.fromJson(data['results'][index]);
    });
    return {'total_items': data['total'], 'totalPages': data['total_pages'], 'results': images};
  }

  Future<Map<String, dynamic>> fetchImagesByAuthor(
      {int page = 1, int perPage = 10, String? authorName}) async {

    String url = '$baseUrl/users/$authorName/photos?page=$page&per_page=$perPage';

    var data = await _getImageData(url);

    List<UnsplashImage> images = data.length == 0 ? [] : List<UnsplashImage>.generate(data.length, (index) {
      return UnsplashImage.fromJson(data[index]);
    });
    return {'total_items': double.infinity, 'totalPages': double.infinity, 'results': images};
  }

  dynamic _getImageData(String url) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));

    request.headers
        .add('Authorization', 'Client-ID ${Keys.unsplashApiAccessKey}');

    HttpClientResponse response = await request.close();

    if (response.statusCode == 200) {
      String json = await response.transform(utf8.decoder).join();
      // Log remaining requests for demo app.
      logger.w(
          'remaining requests: ${response.headers['x-ratelimit-remaining']}');
      return jsonDecode(json);
    } else {
      logger.i(
          "Error fetching image data from Unsplash: ${response.statusCode} - ${response.reasonPhrase}");
      return [];
    }
  }

  Future<dynamic> fetchImageData(String imageId) async {
    String imageUrl = '$baseUrl/photos/$imageId';
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(imageUrl));
    request.headers
        .add('Authorization', 'Client-ID ${Keys.unsplashApiAccessKey}');
    HttpClientResponse response = await request.close();
    if (response.statusCode == 200) {
      String json = await response.transform(utf8.decoder).join();
      // Log remaining requests for demo app.
      logger.w(
          'remaining requests: ${response.headers['x-ratelimit-remaining']}');
      return jsonDecode(json);
    } else {
      logger.i(
          "Error fetching image data from Unsplash: ${response.statusCode} - ${response.reasonPhrase}");
      return null;
    }
  }

  Future<dynamic> fetchAuthorData(String userName) async {

    String url = '$baseUrl/users/$userName';

    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
    request.headers
        .add('Authorization', 'Client-ID ${Keys.unsplashApiAccessKey}');
    HttpClientResponse response = await request.close();
    if (response.statusCode == 200) {
      String json = await response.transform(utf8.decoder).join();
      // Log remaining requests for demo app.
      logger.w(
          'remaining requests: ${response.headers['x-ratelimit-remaining']}');
      return jsonDecode(json);
    } else {
      logger.i(
          "Error fetching user data from Unsplash: ${response.statusCode} - ${response.reasonPhrase}");
      return null;
    }
  }
}
