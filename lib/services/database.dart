import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/models/publiclist.dart';
import 'package:flutter_firebase/models/user.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
}
