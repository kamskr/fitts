// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_perform_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExercisePerformHistory _$ExercisePerformHistoryFromJson(
        Map<String, dynamic> json) =>
    ExercisePerformHistory(
      datePerformed: DateTime.parse(json['datePerformed'] as String),
      details:
          WorkoutExercise.fromJson(json['details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExercisePerformHistoryToJson(
        ExercisePerformHistory instance) =>
    <String, dynamic>{
      'datePerformed': instance.datePerformed.toIso8601String(),
      'details': instance.details.toJson(),
    };
