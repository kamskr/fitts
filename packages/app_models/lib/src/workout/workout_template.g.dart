// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutTemplate _$WorkoutTemplateFromJson(Map<String, dynamic> json) =>
    WorkoutTemplate(
      id: json['id'] as String,
      name: json['name'] as String,
      notes: json['notes'] as String,
      tonnageLifted: json['tonnageLifted'] as int,
      workoutsCompleted: json['workoutsCompleted'] as int,
      averageWorkoutLength: json['averageWorkoutLength'] as int?,
      lastAverageRestTime: json['lastAverageRestTime'] as int?,
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => WorkoutExercise.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastPerformed: json['lastPerformed'] == null
          ? null
          : DateTime.parse(json['lastPerformed'] as String),
      recentTotalTonnageLifted:
          (json['recentTotalTonnageLifted'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList(),
    );

Map<String, dynamic> _$WorkoutTemplateToJson(WorkoutTemplate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'notes': instance.notes,
      'tonnageLifted': instance.tonnageLifted,
      'workoutsCompleted': instance.workoutsCompleted,
      'averageWorkoutLength': instance.averageWorkoutLength,
      'lastAverageRestTime': instance.lastAverageRestTime,
      'lastPerformed': instance.lastPerformed?.toIso8601String(),
      'recentTotalTonnageLifted': instance.recentTotalTonnageLifted,
      'exercises': instance.exercises.map((e) => e.toJson()).toList(),
    };
