import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:singular_test/services/firebase/firestore_service.dart';
import 'package:singular_test/utils/constants.dart';

class FirebaseAuthProvider extends GetxController {
  static FirebaseAuthProvider instance = Get.find();

  final Rx<User?> _firebaseUser = FirebaseAuth.instance.currentUser.obs;
  User? get firebaseUser => _firebaseUser.value;
  set firebaseUser(User? user) => _firebaseUser.value = user;

  signInUserAnonymously() {
    FirebaseAuth.instance.signInAnonymously();
  }

  @override
  void onReady() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        signInUserAnonymously();
      } else {
        firebaseUser = user;
        FirestoreService().createUser(user);
      }
    });
  }
}
