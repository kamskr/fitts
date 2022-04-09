// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_update_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileUpdatePayload _$UserProfileUpdatePayloadFromJson(
        Map<String, dynamic> json) =>
    UserProfileUpdatePayload(
      json['email'] as String,
      json['photoUrl'] as String,
      json['displayName'] as String,
      json['goal'] as String,
      json['gender'] as String,
      DateTime.parse(json['dateOfBirth'] as String),
      json['height'] as int,
      (json['weight'] as num).toDouble(),
    );

Map<String, dynamic> _$UserProfileUpdatePayloadToJson(
        UserProfileUpdatePayload instance) =>
    <String, dynamic>{
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'displayName': instance.displayName,
      'goal': instance.goal,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      'height': instance.height,
      'weight': instance.weight,
    };
