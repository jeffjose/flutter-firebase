import 'package:cloud_firestore/cloud_firestore.dart';

class PublicListItem {
  String id;
  String name;
  String user;

  PublicListItem({this.id, this.name, this.user});

  PublicListItem.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    name = documentSnapshot.data()['name'];
    user = documentSnapshot.data()['user'];
  }
}
