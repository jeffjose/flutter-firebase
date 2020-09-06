import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User> _user = Rx<User>();

  User get user => _user.value;

  @override
  onInit() {
    _user.bindStream(_auth.authStateChanges());
  }
}
