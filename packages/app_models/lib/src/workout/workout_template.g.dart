// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutTemplate _$WorkoutTemplateFromJson(Map<String, dynamic> json) =>
    WorkoutTemplate(
      name: json['name'] as String,
      notes: json['notes'] as String,
      tonnageLifted: json['tonnageLifted'] as int,
      workoutsCompleted: json['workoutsCompleted'] as int,
      averageWorkoutLength: json['averageWorkoutLength'] as int,
      lastAverageRestTime: json['lastAverageRestTime'] as int,
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => WorkoutExercise.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkoutTemplateToJson(WorkoutTemplate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'notes': instance.notes,
      'tonnageLifted': instance.tonnageLifted,
      'workoutsCompleted': instance.workoutsCompleted,
      'averageWorkoutLength': instance.averageWorkoutLength,
      'lastAverageRestTime': instance.lastAverageRestTime,
      'exercises': instance.exercises.map((e) => e.toJson()).toList(),
    };
