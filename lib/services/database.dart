import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase/controllers/auth.dart';
import 'package:flutter_firebase/models/publiclist.dart';
import 'package:flutter_firebase/models/privilagedlist.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:get/get.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final authController = AuthController();

  Stream<List<PublicListItem>> publicListStream() {
    return _firestore
        .collection('publiclist')
        .snapshots()
        .map((QuerySnapshot query) {
      List<PublicListItem> retVal = List();
      query.docs.forEach((element) {
        retVal.add(PublicListItem.fromDocumentSnapshot(element));
      });

      return retVal;
    });
  }

  Stream<List<PrivilagedListItem>> privilagedListStream(uid) {
    print('----------- querying for ${authController.user}');

    authController.obs.stream.listen(print);

    return _firestore
        .collection('privilagedlist')
        .where("user", isEqualTo: uid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<PrivilagedListItem> retVal = List();
      print('Fetched ${query.docs.length} PrivilgedListItems');
      query.docs.forEach((element) {
        retVal.add(PrivilagedListItem.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }
}
