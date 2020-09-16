import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:path_provider/path_provider.dart';
import '../stores/store.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['email']);
FirebaseAuth _auth = FirebaseAuth.instance;

authListener() {
  FirebaseAuth.instance.authStateChanges().listen((user) {
    print('[AUTH]: user changed');
    print(user);

    if (user != null) {
      print('login');
      store.user.state = user;

      FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'displayName': user.displayName,
        'email': user.email,
        // TODO: Add more fields
      });
    } else {
      print('logout');
      store.user.state = null;
    }
  });
}

signInWithGoogle() async {
  GoogleSignInAccount googleUser = await _googleSignIn.signIn();

  GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

  await _auth.signInWithCredential(credential);
}

_deleteCacheAndStorage() async {
  final cacheDir = await getTemporaryDirectory();
  if (cacheDir.existsSync()) {
    cacheDir.deleteSync(recursive: true);
  }

  final appDir = await getApplicationSupportDirectory();
  if (appDir.existsSync()) {
    appDir.deleteSync(recursive: true);
  }
}

signOut() async {
  await _deleteCacheAndStorage();
  await _googleSignIn.signOut();
  await _auth.signOut();
}
