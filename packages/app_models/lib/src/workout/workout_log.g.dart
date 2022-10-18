// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutLog _$WorkoutLogFromJson(Map<String, dynamic> json) => WorkoutLog(
      id: json['id'] as String,
      duration: json['duration'] as int,
      datePerformed: DateTime.parse(json['datePerformed'] as String),
      workoutTemplate: WorkoutTemplate.fromJson(
          json['workoutTemplate'] as Map<String, dynamic>),
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => WorkoutExercise.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkoutLogToJson(WorkoutLog instance) =>
    <String, dynamic>{
      'id': instance.id,
      'duration': instance.duration,
      'datePerformed': instance.datePerformed.toIso8601String(),
      'workoutTemplate': instance.workoutTemplate.toJson(),
      'exercises': instance.exercises.map((e) => e.toJson()).toList(),
    };
