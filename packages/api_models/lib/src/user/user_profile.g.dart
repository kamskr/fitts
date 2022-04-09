// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String,
      displayName: json['displayName'] as String,
      goal: json['goal'] as String,
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      height: json['height'] as int,
      weight: (json['weight'] as num).toDouble(),
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'displayName': instance.displayName,
      'goal': instance.goal,
      'gender': _$GenderEnumMap[instance.gender],
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      'height': instance.height,
      'weight': instance.weight,
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
};
