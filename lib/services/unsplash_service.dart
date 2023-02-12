import 'dart:convert';
import 'dart:io';
import 'package:singular_test/config/keys.dart';
import '../models/unsplash_image.dart';
import '../utils/constants.dart';

class Unsplash {

  static const String baseUrl = 'https://api.unsplash.com';

  static Future<List<UnsplashImage>> loadImages(
      {int page = 1, int perPage = 10, String? keyword}) async {
    logger.i('keyword: $keyword');
    String url = '$baseUrl/photos?page=$page&per_page=$perPage';

    var data = await _getImageData(url);

    List<UnsplashImage> images = List<UnsplashImage>.generate(data.length, (index) {
      return UnsplashImage.fromJson(data[index]);
    });
    return images;
  }

  static Future<Map<String, dynamic>> loadImagesByKeyword(
      {int page = 1, int perPage = 10, String? keyword}) async {
    logger.i('keyword: $keyword');
    String url = '$baseUrl/search/photos?query=$keyword&page=$page&per_page=$perPage&order_by=popular';

    var data = await _getImageData(url);

    List<UnsplashImage> images = data['results'].length == 0 ? [] : List<UnsplashImage>.generate(data['results'].length, (index) {
      return UnsplashImage.fromJson(data['results'][index]);
    });
    return {'total_items': data['total'], 'totalPages': data['total_pages'], 'results': images};
  }

  static dynamic _getImageData(String url) async {
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));

    // pass the access key in the header
    request.headers
        .add('Authorization', 'Client-ID ${Keys.unsplashApiAccessKey}');

    // wait for response
    HttpClientResponse response = await request.close();
    // Process the response
    if (response.statusCode == 200) {
      // response: OK
      // decode JSON
      String json = await response.transform(utf8.decoder).join();
      // return decoded json
      // Log remaining requests for demo app.
      logger.w(
          'remaining requests: ${response.headers['x-ratelimit-remaining']}');
      return jsonDecode(json);
    } else {
      // something went wrong :(
      logger.i(
          "Error fetching image data from Unsplash: ${response.statusCode} - ${response.reasonPhrase}");
      // return empty list
      return [];
    }
  }
}
