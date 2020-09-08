import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['email']);
FirebaseAuth _auth = FirebaseAuth.instance;

authListener() {
  FirebaseAuth.instance.authStateChanges().listen((user) {
    print('[AUTH]: user changed');
    print(user);
  });
}

signInWithGoogle() async {
  GoogleSignInAccount googleUser = await _googleSignIn.signIn();

  GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

  await _auth.signInWithCredential(credential);
}

signOut() async {
  _auth.signOut();
}
