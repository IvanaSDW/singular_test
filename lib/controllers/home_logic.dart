import 'package:get/get.dart';


class HomeLogic extends GetxController {
  final RxInt _currentTab = 0.obs;
  int get currentTab => _currentTab.value;
  set currentTab(int value) => _currentTab.value = value;

  String defaultGalleryTitle = 'Popular Images';
  String defaultFavoritesTitle = 'My Favorites';
  RxString galleryTitle = 'Popular Images'.obs;
  RxString favoritesTitle = 'My Favorites'.obs;
}
