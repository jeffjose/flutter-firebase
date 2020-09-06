import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';

import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
]);

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User> _user = Rx<User>();

  User get user => _user.value;

  @override
  onInit() {
    _user.bindStream(_auth.authStateChanges());

    print('is signed in');
    print(_googleSignIn.isSignedIn());
    _googleSignIn.signInSilently();
  }

  void login() async {
    try {
      await _googleSignIn.signIn();
    } catch (e) {
      print(e.message);
    }
  }
}
