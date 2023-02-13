import 'package:get/get.dart';

import 'image_detail_logic.dart';

class ImageDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ImageDetailLogic());
  }
}
