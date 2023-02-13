import 'package:get/get.dart';
import 'package:singular_test/bindings/home_binding.dart';
import 'package:singular_test/routes/app_routes.dart';
import 'package:singular_test/ui/pages/author_detail/author_view.dart';
import 'package:singular_test/ui/pages/author_detail/author_view_binding.dart';
import 'package:singular_test/ui/pages/home/home_view.dart';
import 'package:singular_test/ui/pages/image_detail/image_detail_binding.dart';
import 'package:singular_test/ui/pages/image_detail/image_detail_view.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.home, page: () => HomePage(), binding: HomeBinding()),
    GetPage(name: Routes.imageDetail, page: () => ImageDetailPage(), binding: ImageDetailBinding()),
    GetPage(name: Routes.authorDetail, page: () => AuthorDetailPage(), binding: AuthorDetailBinding()),
  ];
}
