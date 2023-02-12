import 'package:get/get.dart';
import 'package:singular_test/bindings/home_binding.dart';
import 'package:singular_test/routes/app_routes.dart';
import 'package:singular_test/ui/pages/home/home_view.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.home, page: () => HomePage(), binding: HomeBinding()),
  ];
}
