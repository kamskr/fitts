// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_update_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileUpdatePayload _$UserProfileUpdatePayloadFromJson(
        Map<String, dynamic> json) =>
    UserProfileUpdatePayload(
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String,
      displayName: json['displayName'] as String,
      goal: json['goal'] as String,
      gender: json['gender'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      height: json['height'] as int,
      weight: (json['weight'] as num).toDouble(),
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
