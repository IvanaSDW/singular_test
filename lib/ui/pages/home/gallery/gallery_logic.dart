import 'package:get/get.dart';
import 'package:singular_test/controllers/home_logic.dart';
import 'package:singular_test/routes/app_routes.dart';
import 'package:singular_test/services/firebase/auth_provider.dart';
import 'package:singular_test/services/firebase/firestore_service.dart';
import 'package:singular_test/utils/constants.dart';
import '../../../../models/unsplash_image.dart';
import '../../../../services/unsplash/unsplash_service.dart';

class GalleryLogic extends GetxController {
  final HomeLogic homeController = Get.find<HomeLogic>();
  RxList<UnsplashImage> images = <UnsplashImage>[].obs;
  final RxInt _page = 0.obs;

  int get page => _page.value;

  set page(int value) => _page.value = value;

  final RxInt _totalPages = (-1).obs;

  int get totalPages => _totalPages.value;

  set totalPages(int value) => _totalPages.value = value;

  final Rx<String> _keyword = ''.obs;

  String get keyword => _keyword.value;

  set keyword(String value) => _keyword.value = value;

  final RxBool _loadingImages = false.obs;

  bool get loadingImages => _loadingImages.value;

  set loadingImages(bool value) => _loadingImages.value = value;

  final RxBool _showSearchBar = false.obs;

  bool get showSearchBar => _showSearchBar.value;

  set showSearchBar(bool value) => _showSearchBar.value = value;

  Future<List<UnsplashImage>> loadUnsplashImages(
      {required bool forward}) async {
    logger.i('called for : $keyword');
    if (loadingImages) {
      return [];
    }

    if (totalPages != -1 && page >= totalPages) {
      return [];
    }
    loadingImages = true;

    List<UnsplashImage> fetchImages;
    var res = await Unsplash().fetchImagesByKeyword(
        keyword: keyword.isEmpty ? 'all' : keyword,
        page: forward
            ? ++page
            : page <= 1
                ? 1
                : --page);
    totalPages = res['totalPages'];
    logger.i('Page: $page');
    fetchImages = res['results'];
    images.value = fetchImages;

    loadingImages = false;
    return fetchImages;
  }

  Future<UnsplashImage?> loadImage(int index) async {
    // check if new images need to be loaded
    return index < images.length ? images[index] : null;
  }

  // Resets to the initial state.
  resetImages() {
    images.value = [];
    page = 0;
    totalPages = -1;
  }

  refreshGallery() {
    images.value = [];
    page = 0;
    totalPages = -1;
    keyword = '';
    homeController.galleryTitle.value = homeController.defaultGalleryTitle;
    loadUnsplashImages(forward: true);
  }

  void submitSearch() async {
    resetImages();
    loadUnsplashImages(forward: true);
    showSearchBar = false;
    homeController.galleryTitle.value = keyword;
  }

  void onAddImageToUserCollection(UnsplashImage image) {
    FirestoreService().addImageToUserFavorites(
        FirebaseAuthProvider().firebaseUser!.uid, image);
  }

  onImageTapped(imageId) =>
      Get.toNamed(Routes.imageDetail, arguments: {'imageId': imageId});

  @override
  void onInit() {
    super.onInit();
    logger.i('called');
    loadUnsplashImages(forward: true);
  }
}
