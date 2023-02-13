import 'package:get/get.dart';

import 'author_view_logic.dart';

class AuthorDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthorDetailLogic());
  }
}
