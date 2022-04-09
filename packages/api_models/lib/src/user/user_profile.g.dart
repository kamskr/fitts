// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String,
      displayName: json['displayName'] as String,
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'displayName': instance.displayName,
    };
