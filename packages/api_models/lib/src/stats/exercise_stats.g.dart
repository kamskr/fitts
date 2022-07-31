// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseStats _$ExerciseStatsFromJson(Map<String, dynamic> json) =>
    ExerciseStats(
      highestWeight: (json['highestWeight'] as num).toDouble(),
      repetitionsDone: json['repetitionsDone'] as int,
      timesPerformed: json['timesPerformed'] as int,
      overallBest:
          OverallBest.fromJson(json['overallBest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExerciseStatsToJson(ExerciseStats instance) =>
    <String, dynamic>{
      'highestWeight': instance.highestWeight,
      'repetitionsDone': instance.repetitionsDone,
      'timesPerformed': instance.timesPerformed,
      'overallBest': instance.overallBest,
    };
