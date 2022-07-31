// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlobalStats _$GlobalStatsFromJson(Map<String, dynamic> json) => GlobalStats(
      keyLifts:
          (json['keyLifts'] as List<dynamic>).map((e) => e as String).toList(),
      liftingTimeSpent: json['liftingTimeSpent'] as int,
      totalKgLifted: json['totalKgLifted'] as int,
      workoutsCompleted: json['workoutsCompleted'] as int,
    );

Map<String, dynamic> _$GlobalStatsToJson(GlobalStats instance) =>
    <String, dynamic>{
      'keyLifts': instance.keyLifts,
      'liftingTimeSpent': instance.liftingTimeSpent,
      'totalKgLifted': instance.totalKgLifted,
      'workoutsCompleted': instance.workoutsCompleted,
    };
