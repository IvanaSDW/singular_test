import 'package:get/get.dart';

import '../models/unsplash_image.dart';
import '../services/unsplash/unsplash_service.dart';
import '../utils/constants.dart';

class HomeLogic extends GetxController {
  final RxInt _currentTab = 0.obs;
  int get currentTab => _currentTab.value;
  set currentTab(int value) => _currentTab.value = value;

  String defaultTitle = 'Unsplash trends';
  RxString homeTitle = 'Unsplash trends'.obs;
}
