import 'package:get/get.dart';
import 'package:singular_test/models/unsplash_image.dart';
import 'package:singular_test/models/unsplash_user.dart';
import 'package:singular_test/services/unsplash/unsplash_service.dart';
import 'package:singular_test/utils/constants.dart';

class ImageDetailLogic extends GetxController {

  final Rx<UnsplashImage?> _currentImage = null.obs;
  UnsplashImage? get currentImage => _currentImage.value;
  set currentImage(UnsplashImage? image) => _currentImage.value = image;

  Future<UnsplashImage?> loadImageFromUnsplash(String imageId) async {
    dynamic imageData = await Unsplash().fetchImageData(imageId);
    logger.i('image author: ${imageData['user']['name']}');
    UnsplashImage image = UnsplashImage.fromJson(imageData);
    logger.i('fetched image: $image');
    return image;
  }

  void onMoreAboutAuthor(String username) async {

  }

  Future<UnsplashUser?> loadUserFromUnsplash(String imageId) async {
    dynamic userData = await Unsplash().fetchImageData(imageId);
    logger.i('author data: ${userData}');
    UnsplashUser user = UnsplashUser.fromJson(userData);
    logger.i('fetched user: $user');
    return user;
  }

}
