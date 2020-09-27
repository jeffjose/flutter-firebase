import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:path_provider/path_provider.dart';
import '../stores/index.dart';
import '../models/index.dart';

import './messaging.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['email']);
FirebaseAuth _auth = FirebaseAuth.instance;

authListener() {
  Stream zippeduser = Rx.race([
    // If idTokenChanges is a "super" stream of authStateChanges,
    // we dont need this `Rx.race`. But since I dont know, I'll keep both
    FirebaseAuth.instance.idTokenChanges(),
    FirebaseAuth.instance.authStateChanges(),
  ]).switchMap((user) {
    return ZipStream.zip2(
        BehaviorSubject.seeded(user),
        FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .snapshots(), (User authuser, DocumentSnapshot firestoreuser) {
      return [authuser, firestoreuser.data()];
    }).onErrorReturnWith((error) {
      print('ZipStream error $error');
      return [null, {}];
    });
  });
  Stream deviceToken = firebaseMessaging.getToken().asStream();

  Rx.combineLatest2(zippeduser, deviceToken, (zippeduser, deviceToken) {
    return [zippeduser[0], zippeduser[1], deviceToken];
  }).listen((data) {
    User authuser = data[0];
    Map firestoreuser = data[1];
    String deviceToken = data[2];

    print('[AUTH]: user changed');
    print("AuthUser $authuser");
    print("Firestore User $firestoreuser");
    print("Device Token $deviceToken");

    if (authuser != null) {
      var doc =
          FirebaseFirestore.instance.collection('users').doc(authuser.uid);

      AppUser user = AppUser(authuser, firestoreuser, deviceToken);

      doc.update({
        'isAnonymouse': user.isAnonymous,
        'uid': user.uid,
        'displayName': user.displayName,
        'email': user.email,
        'photoURL': user.photoURL,
        'deviceTokens': FieldValue.arrayUnion([deviceToken]),
      });

      store.user.state = user;
    } else {
      store.user.state = null;
    }
  });
}

linkWithGoogle() async {
  print("[AUTH] Link with Google");
  GoogleSignInAccount googleUser = await _googleSignIn.signIn();

  GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  OAuthCredential credential =
      GoogleAuthProvider.credential(idToken: googleAuth.idToken);
  await FirebaseAuth.instance.currentUser.linkWithCredential(credential);
}

signInWithGoogle() async {
  print("[AUTH] Signin with Google");
  try {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    await _auth.signInWithCredential(credential);
  } catch (e) {
    print(
        "[AUTH]: Google SignIn error. Have you forgotten to register the app in Firebase?");
    rethrow;
  }
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

signinAnonymously() async {
  await FirebaseAuth.instance.signInAnonymously();
}

signIn() async {
  try {
    print('[AUTH]: Google Sign (Silent)');
    await _googleSignIn.signInSilently(suppressErrors: false);
  } catch (e) {
    print('[AUTH]: Google Sign in (Silent) failed. Doing Anon');
    await signinAnonymously();
  }
}

signOut() async {
  await _deleteCacheAndStorage();
  await _googleSignIn.signOut();
  await _auth.signOut();

// Since the app is functional even after logout, mint a new id.
  await signinAnonymously();
}
