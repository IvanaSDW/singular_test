import 'package:get/get.dart';

import 'FavoritesLogic.dart';

class FavoritesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoritesLogic());
  }
}
