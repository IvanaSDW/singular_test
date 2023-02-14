import 'package:get/get.dart';

import '../../../models/unsplash_user.dart';
import '../../../services/unsplash/unsplash_service.dart';


class AuthorDetailLogic extends GetxController {

  Future<UnsplashUser?> loadUserFromUnsplash(String userName) async {
    dynamic userData = await Unsplash().fetchAuthorData(userName);
    if (userData == null) {
      return null;
    }
    UnsplashUser user = UnsplashUser.fromJson(userData);
    return user;
  }

}
