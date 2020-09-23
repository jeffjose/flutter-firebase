import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_string/to_string.dart';
import 'package:json_annotation/json_annotation.dart';

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
