import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_firebase/stores/store.dart';

void collectionListener() {
  FirebaseAuth.instance.authStateChanges().listen((user) {
    print('[COLLECTION]: user changed');
    print(user);

    store.emailx.state = user?.email;
  });

  FirebaseFirestore.instance.collection('publiclist').snapshots().listen((x) {
    print(x);
  });
}
