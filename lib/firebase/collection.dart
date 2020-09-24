import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../stores/index.dart';
import '../models/index.dart';

void collectionListener() {
  FirebaseAuth.instance.authStateChanges().listen((user) {
    print('[COLLECTION]: user changed $user');

    if (user != null) {
      FirebaseFirestore.instance
          .collection('privilagedlist')
          .where('user', isEqualTo: user.uid)
          .snapshots()
          .listen((QuerySnapshot snapshot) {
        List<PrivilagedListItem> retVal = List();

        snapshot.docs.forEach((el) {
          retVal.add(PrivilagedListItem.fromJson(el.data()));
        });

        store.privilagedStore.state = retVal;
      }).onError((e) {
        print('Handling this error');
        print(e);
        store.privilagedStore.state = [];
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
      retVal.add(PublicListItem.fromJson(el.data()));
    });

    store.publicStore.state = retVal;
  });
}

void addItemToCollection(String collectionName) {
  CollectionReference collection =
      FirebaseFirestore.instance.collection(collectionName);

  User user = FirebaseAuth.instance.currentUser;

  String string = "$collectionName item (flutter) ${Random().nextInt(100)}";

  print('$collectionName: Adding item');
  if (collectionName == "privilagedlist") {
    if (user != null) {
      collection.add({'name': string, 'user': user.uid});
    }
  } else {
    collection
        .add({'name': string, 'user': (user != null) ? user.uid : "anon"});
  }
}

void removeItemFromCollection(String collectionName) {
  CollectionReference collection =
      FirebaseFirestore.instance.collection(collectionName);

  User user = FirebaseAuth.instance.currentUser;

  if ((user != null) || collectionName == "publiclist") {
    print('$collectionName: Removing item');
    collection
        .orderBy(FieldPath.documentId)
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs[0].reference.delete();
    });
  }
}
