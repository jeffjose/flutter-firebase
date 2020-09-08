import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';

import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User> _user = Rx<User>();

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]);

  User get user => _user.value;

  @override
  onReady() async {
    ever(_user, handleAuthChanged);
    _user.bindStream(_auth.authStateChanges());
    super.onReady();
  }

  @override
  onInit() {
    print('signing in silently ..');
    _googleSignIn.signInSilently();
  }

  handleAuthChanged(_user) async {
    if (_user?.uid != null) {
      print('Auth state changed!');
    }
  }

  void logout() {
    //FirebaseFirestore.instance.clearPersistence();
    _googleSignIn.signOut();
    _auth.signOut();
  }

  void login() async {
    try {
      print('Signing in ...');
      print(await _googleSignIn.isSignedIn());
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();

      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
    } catch (e) {
      print('sign in error');
      print(e.message);
    }
  }
}
