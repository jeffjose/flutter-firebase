import 'package:cloud_firestore/cloud_firestore.dart';

class PrivilagedListItem {
  String id;
  String name;
  String user;

  PrivilagedListItem({this.id, this.name, this.user});

  PrivilagedListItem.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    name = documentSnapshot.data()['name'];
    user = documentSnapshot.data()['user'];
  }
}
