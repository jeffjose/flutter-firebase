// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicListItem _$PublicListItemFromJson(Map<String, dynamic> json) {
  return PublicListItem(
    name: json['name'] as String,
    user: json['user'] as String,
  );
}

Map<String, dynamic> _$PublicListItemToJson(PublicListItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'user': instance.user,
    };

PrivilagedListItem _$PrivilagedListItemFromJson(Map<String, dynamic> json) {
  return PrivilagedListItem(
    name: json['name'] as String,
    user: json['user'] as String,
  );
}

Map<String, dynamic> _$PrivilagedListItemToJson(PrivilagedListItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'user': instance.user,
    };

// **************************************************************************
// ToStringGenerator
// **************************************************************************

String _$AppUserToString(AppUser o) {
  return """AppUser{
  uid: ${o.uid},
  email: ${o.email},
  displayName: ${o.displayName},
  photoURL: ${o.photoURL},
  deviceToken: ${o.deviceToken},
}""";
}

String _$PublicListItemToString(PublicListItem o) {
  return """PublicListItem{
  name: ${o.name},
  user: ${o.user},
}""";
}

String _$PrivilagedListItemToString(PrivilagedListItem o) {
  return """PrivilagedListItem{
  name: ${o.name},
  user: ${o.user},
}""";
}
