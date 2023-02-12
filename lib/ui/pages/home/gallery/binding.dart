import 'package:get/get.dart';

import 'gallery_logic.dart';

class GalleryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GalleryLogic());
  }
}
