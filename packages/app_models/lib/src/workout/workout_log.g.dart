// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutLog _$WorkoutLogFromJson(Map<String, dynamic> json) => WorkoutLog(
      duration: json['duration'] as int,
      datePerformed: DateTime.parse(json['datePerformed'] as String),
      workoutTemplateId: json['workoutTemplateId'] as String,
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => WorkoutExercise.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkoutLogToJson(WorkoutLog instance) =>
    <String, dynamic>{
      'duration': instance.duration,
      'datePerformed': instance.datePerformed.toIso8601String(),
      'workoutTemplateId': instance.workoutTemplateId,
      'exercises': instance.exercises.map((e) => e.toJson()).toList(),
    };
