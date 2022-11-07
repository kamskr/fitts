// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_tonnage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentTonnage _$RecentTonnageFromJson(Map<String, dynamic> json) =>
    RecentTonnage(
      timePerformed: DateTime.parse(json['timePerformed'] as String),
      weight: (json['weight'] as num).toDouble(),
    );

Map<String, dynamic> _$RecentTonnageToJson(RecentTonnage instance) =>
    <String, dynamic>{
      'timePerformed': instance.timePerformed.toIso8601String(),
      'weight': instance.weight,
    };
