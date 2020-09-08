import 'package:stream_state/stream_state.dart';

//class PublicListItem {
//  final String name;
//  final String email;
//
//  PublicListItem({
//    this.name,
//    this.email,
//  })
//
//  PublicListItem.fromMap(dynamic map) :
//  name = map['name'],
//  email = map['email'];
//
//  Map<String, dynamic> toMap() => {
//    'name': name, 'email': email,
//
//  };
//}
//
//class PrivilagedListItem {
//  final String name;
//  final String email;
//
//  PrivilagedListItem({
//    this.name,
//    this.email,
//  })
//
//  PrivilagedListItem.fromMap(dynamic map) :
//  name = map['name'], email = map['email'];
//
//  Map<String, dynamic> toMap() => {
//    'name': name, 'email': email,
//
//  };
//}

class Store {
  static final Store _singleton = Store._internal();
  factory Store() => _singleton;
  Store._internal();

  var emailx = StreamState<String>(initial: 'none');
//  var publicStore = StreamState<List<PublicListItem>>(
//      serialize: (state) => state.toMap(),
//      deserialize: (serialized) => PublicListItem.fromMap(serialized));
//  var privilagedStore = StreamState<List<PrivilagedListItem>>(
//      serialize: (state) => state.toMap(),
//      deserialize: (serialized) => PublicListItem.fromMap(serialized));
}

final store = Store();
