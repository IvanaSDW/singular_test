import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:singular_test/models/unsplash_image.dart';
import '../../models/app_user.dart';
import '../../utils/constants.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<AppUser> get usersCollection =>
      _firestore.collection('SingularUsers').withConverter<AppUser>(
          fromFirestore: (snapshot, _) => AppUser.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson());

  void createUser(User user) async {
    AppUser userObject = AppUser(
      userId: user.uid,
      name: user.displayName ?? 'guest user',
      email: user.email,
      avatarUrl: user.photoURL,
    );
    DocumentReference userReference = usersCollection.doc(userObject.userId);
    DocumentSnapshot userSnapshot = await userReference.get();
    if (!userSnapshot.exists) {
      await userReference.set(userObject).then((value) {
        logger.i('User ${userObject.userId} added.');
      }).catchError((error) {
        logger.e('Error creating user: ${error.toString()}');
      });
    }
  }

  Future<AppUser?> fetchUser(String userId) async {
    final fetchedUser = await usersCollection
        .doc(userId)
        .withConverter<AppUser>(
            fromFirestore: (snapshot, _) => AppUser.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson())
        .get()
        .then((value) => value.data());
    return fetchedUser;
  }

  Future<UnsplashImage?> fetchFavImage(String userId, String imageId) async {
    logger.i('fetching image= $imageId, user= $userId');
    final fetchedImage = await usersCollection
        .doc(userId)
    .collection('favorites')
    .doc(imageId)
        .withConverter<UnsplashImage>(
        fromFirestore: (snapshot, _) => UnsplashImage.fromFirebase(snapshot.data()!),
        toFirestore: (image, _) => image.toJson())
        .get()
        .then((value) => value.data());
    logger.i('just fetched image: ${fetchedImage!.author.userName}');
    return fetchedImage;
  }

  addImageToUserFavorites(String userId, UnsplashImage image) {
    usersCollection
        .doc(userId)
        .collection('favorites')
        .doc(image.id)
        .set(image.toJson());
  }

  removeImageFromUserFavorites(String userId, String imageId) {
    usersCollection.doc(userId).collection('favorites').doc(imageId).delete();
  }

  Future<List<UnsplashImage>> fetchFavImages({required String userId}) async {
    return await usersCollection
        .doc(userId)
        .collection('favorites')
        .withConverter(
            fromFirestore: (snapshot, _) =>
                UnsplashImage.fromFirebase(snapshot.data()!),
            toFirestore: (image, _) => image.toJson())
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
  }

  Query<UnsplashImage> imagesByKeyword(String userId, String keyword) {
    logger.i('Query for: $keyword');
    return usersCollection
        .doc(userId)
        .collection('favorites')
        .where('altDescription', isGreaterThanOrEqualTo: keyword)
        .withConverter<UnsplashImage>(
            fromFirestore: (snapshot, _) =>
                UnsplashImage.fromFirebase(snapshot.data()!),
            toFirestore: (image, _) => image.toJson());
  }

  Future<List<UnsplashImage>> fetchFavImagesByKeyword(
      {required String userId, required String keyword}) async {
    logger.i('fetching: $keyword');
    return await usersCollection
        .doc(userId)
        .collection('favorites')
        .withConverter(
            fromFirestore: (snapshot, _) =>
                UnsplashImage.fromFirebase(snapshot.data()!),
            toFirestore: (image, _) => image.toJson())
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList()
        .where((image) => (
        (image.altDescription != null && image.altDescription!.contains(keyword))
        || (image.description != null && image.description!.contains(keyword))
    )
    ).toList());
  }

}
