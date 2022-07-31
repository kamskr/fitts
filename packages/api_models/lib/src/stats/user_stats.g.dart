// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserStats _$UserStatsFromJson(Map<String, dynamic> json) => UserStats(
      exercisesStats: (json['exercisesStats'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, ExerciseStats.fromJson(e as Map<String, dynamic>)),
      ),
      globalStats:
          GlobalStats.fromJson(json['globalStats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserStatsToJson(UserStats instance) => <String, dynamic>{
      'exercisesStats': instance.exercisesStats,
      'globalStats': instance.globalStats,
    };
