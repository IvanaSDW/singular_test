import 'package:get/get.dart';
import 'package:singular_test/ui/pages/home/gallery/gallery_logic.dart';

import '../controllers/home_logic.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeLogic());
    Get.lazyPut(() => GalleryLogic());
  }
}
