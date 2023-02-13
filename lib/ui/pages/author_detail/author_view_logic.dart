import 'package:get/get.dart';

import '../../../models/unsplash_user.dart';
import '../../../services/unsplash/unsplash_service.dart';
import '../../../utils/constants.dart';

class AuthorDetailLogic extends GetxController {

  Future<UnsplashUser?> loadUserFromUnsplash(String userName) async {
    dynamic userData = await Unsplash().fetchAuthorData(userName);
    logger.i('author data: ${userData}');
    if (userData == null) {
      return null;
    }
    UnsplashUser user = UnsplashUser.fromJson(userData);
    logger.i('fetched user: $user');
    return user;
  }

}
