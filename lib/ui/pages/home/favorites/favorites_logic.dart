import 'package:get/get.dart';
import '../../../../controllers/home_logic.dart';
import '../../../../models/unsplash_image.dart';
import '../../../../routes/app_routes.dart';
import '../../../../services/firebase/auth_provider.dart';
import '../../../../services/firebase/firestore_service.dart';

class FavoritesLogic extends GetxController {
  final HomeLogic homeController = Get.find<HomeLogic>();

  RxList<UnsplashImage> currentImages = <UnsplashImage>[].obs;

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

  Future<List<UnsplashImage>> loadFavImages() async {

    if (totalPages != -1 && page >= totalPages) {
      return [];
    }
    loadingImages = true;

    List<UnsplashImage> fetchImages;

    fetchImages = await FirestoreService()
        .fetchFavImages(userId: FirebaseAuthProvider().firebaseUser!.uid);

    currentImages.value = fetchImages;

    loadingImages = false;
    return fetchImages;
  }

  Future<List<UnsplashImage>> loadFavImagesByKeyword() async {

    if (loadingImages) {
      return [];
    }

    if (totalPages != -1 && page >= totalPages) {
      return [];
    }
    loadingImages = true;

    List<UnsplashImage> fetchImages;

    fetchImages = await FirestoreService()
        .fetchFavImagesByKeyword(userId: FirebaseAuthProvider().firebaseUser!.uid, keyword: keyword);
    currentImages.value = fetchImages;

    loadingImages = false;
    return fetchImages;
  }

  Future<UnsplashImage?> loadImage(int index) async {
    // check if new images need to be loaded
    return index < currentImages.length ? currentImages[index] : null;
  }

  // Resets to the initial state.
  resetImages() {
    currentImages.value = [];
    page = 0;
    totalPages = -1;
  }

  refreshGallery() {
    currentImages.value = [];
    page = 0;
    totalPages = -1;
    keyword = '';
    homeController.favoritesTitle.value = homeController.defaultFavoritesTitle;
    loadFavImages();
  }

  void submitSearch() async {
    resetImages();
    loadFavImagesByKeyword();
    showSearchBar = false;
    homeController.favoritesTitle.value = keyword;
  }

  onImageTapped(imageId) =>
      Get.toNamed(Routes.imageDetail, arguments: {'imageId': imageId, 'source': 'local'});

  void onRemoveImageFromUserCollection(String imageId) async {
    await FirestoreService().removeImageFromUserFavorites(
        FirebaseAuthProvider().firebaseUser!.uid, imageId)
        .then((value) => refreshGallery());
  }

  @override
  void onInit() {
    super.onInit();
    loadFavImages();
  }
}
