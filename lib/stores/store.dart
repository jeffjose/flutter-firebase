import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stream_state/stream_state.dart';
import 'package:flutter_firebase/themes/theme.dart';

class AppTheme {
  final Color backgroundColor;
  final Color bodyColor;
  final Color appBarColor;
  final Color appBarBackgroundColor;

  AppTheme(
      {this.backgroundColor,
      this.bodyColor,
      this.appBarBackgroundColor,
      this.appBarColor});
}

class PublicListItem {
  final String name;
  final String user;

  PublicListItem({
    this.name,
    this.user,
  });

  PublicListItem.fromMap(dynamic map)
      : name = map['name'],
        user = map['user'];

  Map<String, dynamic> toMap() => {
        'name': name,
        'user': user,
      };
}

class PrivilagedListItem {
  final String name;
  final String user;

  PrivilagedListItem({
    this.name,
    this.user,
  });

  PrivilagedListItem.fromMap(dynamic map)
      : name = map['name'],
        user = map['user'];

  Map<String, dynamic> toMap() => {
        'name': name,
        'user': user,
      };
}

class Store {
  static final Store _singleton = Store._internal();
  factory Store() => _singleton;
  Store._internal();

  var email = StreamState<String>(initial: 'none');
  var publicStore = StreamState<List<PublicListItem>>(
    initial: [],
    //serialize: (state) => state.toMap(),
    //deserialize: (serialized) => PublicListItem.fromMap(serialized)
  );
  var privilagedStore = StreamState<List<PrivilagedListItem>>(
    initial: [],
    //serialize: (state) => state.toMap(),
    //deserialize: (serialized) => PublicListItem.fromMap(serialized)
  );

  var user = StreamState<User>(initial: null);

  var darkMode = StreamState<bool>(initial: true);

  // Initialize with darkModeTheme
  var theme = StreamState<AppTheme>(initial: darkModeTheme);
}

final store = Store();
