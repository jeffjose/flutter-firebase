import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_firebase/stores/store.dart';

void collectionListener() {
  FirebaseAuth.instance.authStateChanges().listen((user) {
    print('[COLLECTION]: user changed');
    print(user);

    store.email.state = user?.email;

    if (user != null) {
      FirebaseFirestore.instance
          .collection('privilagedlist')
          .where('user', isEqualTo: user.uid)
          .snapshots()
          .listen((QuerySnapshot snapshot) {
        List<PrivilagedListItem> retVal = List();

        snapshot.docs.forEach((el) {
          print(el.data());
          retVal.add(PrivilagedListItem.fromMap(el.data()));
        });

        store.privilagedStore.state = retVal;
      });
    } else {
      store.privilagedStore.state = [];
    }
  });

  FirebaseFirestore.instance
      .collection('publiclist')
      .snapshots()
      .listen((QuerySnapshot snapshot) {
    List<PublicListItem> retVal = List();

    snapshot.docs.forEach((el) {
      print(el.data());
      retVal.add(PublicListItem.fromMap(el.data()));
    });

    store.publicStore.state = retVal;
  });
}
