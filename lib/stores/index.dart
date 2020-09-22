import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stream_state/stream_state.dart';
import 'package:to_string/to_string.dart';
import '../themes/index.dart';

part 'index.g.dart';

@ToString()
class AppUser {
  String uid;
  String email;
  String displayName;
  String photoURL;
  String deviceToken;

  AppUser(User user, String deviceToken) {
    print('[AppUser] $user, $deviceToken');
    if (user != null) {
      this.uid = user.uid;
      this.email = user.email;
      this.displayName = user.displayName;
      this.photoURL = user.photoURL;
    }

    this.deviceToken = deviceToken;
  }

  logout() {
    this.uid = null;
    this.email = null;
    this.displayName = null;
    this.photoURL = null;

    // Dont set `this.token` to null since that isnt tied to Firebase User
  }

  @override
  String toString() {
    return _$AppUserToString(this);
  }
}

class AppTheme {
  final Color backgroundColor;
  final Color bodyColor;
  final Color appBarColor;
  final Color appBarBackgroundColor;

  AppTheme({
    this.backgroundColor,
    this.bodyColor,
    this.appBarBackgroundColor,
    this.appBarColor,
  });
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
    //serialize: (state) => jsonEncode(state),
    //deserialize: (str) => jsonDecode(str),
  );

  var privilagedStore = StreamState<List<PrivilagedListItem>>(
    initial: [],
    //serialize: (state) => state.toMap(),
    //deserialize: (serialized) => PublicListItem.fromMap(serialized)
  );

  var user = StreamState<AppUser>(initial: null);

  var darkMode = StreamState<bool>(
      initial: true, persist: true, persistPath: '/settings/darkmode');

  // Initialize with darkModeTheme
  var theme = StreamState<AppTheme>(initial: darkModeTheme);
}

final store = Store();
