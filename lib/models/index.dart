import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_string/to_string.dart';
import 'package:json_annotation/json_annotation.dart';

part 'index.g.dart';

@ToString()
class AppUser {
  bool isAnonymous = true;
  String uid;
  String email;
  String displayName;
  String photoURL;
  String deviceToken;

  factory AppUser.anonymous() {
    return AppUser(null, null, null);
  }

  Map mergeUserInfo(User user, Map firestoreuser) {
    Map info = {};

    // Loop through `User.providerData` in the reverse order to merge and create
    // one info object
    for (int i = user.providerData.length - 1; i >= 0; i--) {
      info['email'] = user.providerData[i].email;
      info['displayName'] = user.providerData[i].displayName;
      info['photoURL'] = user.providerData[i].photoURL;
    }

    // Now merge with the `User` info, if it exists
    info['displayName'] = user.displayName ?? info['displayName'];
    info['photoURL'] = user.photoURL ?? info['photoURL'];

    // Now overwrite info that exists in Firestore (which means the user overrode
    // things like displayName or photoURL)
    info['displayName'] = firestoreuser['displayName'] ?? info['displayName'];
    info['photoURL'] = firestoreuser['photoURL'] ?? info['photoURL'];

    return info;
  }

  AppUser(User user, Map firestoreuser, String deviceToken) {
    print('[AppUser] $user, $firestoreuser, $deviceToken');

    if (user != null) {
      Map info = mergeUserInfo(user, firestoreuser);

      this.uid = user.uid;
      this.isAnonymous = user.isAnonymous;

      this.email = info['email'];
      this.displayName = info['displayName'];
      this.photoURL = info['photoURL'];
    }

    if (firestoreuser != null) {
      //this.attributeFromFirestore = firestoreuser['attributeFromFirestore'];
    }

    this.deviceToken = deviceToken;
  }

  logout() {
    this.isAnonymous = null;
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

@ToString()
@JsonSerializable()
class PublicListItem {
  final String name;
  final String user;

  PublicListItem({
    this.name,
    this.user,
  });

  factory PublicListItem.fromJson(Map<String, dynamic> json) =>
      _$PublicListItemFromJson(json);
  Map<String, dynamic> toJson() => _$PublicListItemToJson(this);

  @override
  String toString() {
    return _$PublicListItemToString(this);
  }
}

@ToString()
@JsonSerializable()
class PrivilagedListItem {
  final String name;
  final String user;

  PrivilagedListItem({
    this.name,
    this.user,
  });

  factory PrivilagedListItem.fromJson(Map<String, dynamic> json) =>
      _$PrivilagedListItemFromJson(json);
  Map<String, dynamic> toJson() => _$PrivilagedListItemToJson(this);

  @override
  String toString() {
    return _$PrivilagedListItemToString(this);
  }
}
