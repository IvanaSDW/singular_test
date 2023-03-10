import 'package:get/get.dart';
import 'package:singular_test/models/unsplash_image.dart';
import 'package:singular_test/models/unsplash_user.dart';
import 'package:singular_test/routes/app_routes.dart';
import 'package:singular_test/services/unsplash/unsplash_service.dart';
import 'package:singular_test/ui/pages/home/favorites/favorites_logic.dart';
import 'package:singular_test/utils/constants.dart';

import '../../../services/firebase/auth_provider.dart';
import '../../../services/firebase/firestore_service.dart';

class ImageDetailLogic extends GetxController {
  final Rx<UnsplashImage?> _currentImage = null.obs;

  UnsplashImage? get currentImage => _currentImage.value;

  set currentImage(UnsplashImage? image) => _currentImage.value = image;

  Future<UnsplashImage?> loadImageFromUnsplash(String imageId) async {
    dynamic imageData = await Unsplash().fetchImageData(imageId);
    UnsplashImage image = UnsplashImage.fromJson(imageData);
    return image;
  }

  Future<UnsplashImage?> loadImageFromFirebase(String imageId) async {
    String userId = FirebaseAuthProvider().firebaseUser!.uid;
    dynamic image = await FirestoreService().fetchFavImage(userId, imageId);
    return image;
  }

  onMoreAboutAuthorTapped(authorName) =>
      Get.toNamed(Routes.authorDetail, arguments: {'authorName': authorName});

  void onAddImageToUserCollection(UnsplashImage image) async {
    FirestoreService()
        .addImageToUserFavorites(
            FirebaseAuthProvider().firebaseUser!.uid, image)
        .then((value) => Get.find<FavoritesLogic>().refreshGallery());
  }
}
