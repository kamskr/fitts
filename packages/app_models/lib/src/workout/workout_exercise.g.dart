// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutExercise _$WorkoutExerciseFromJson(Map<String, dynamic> json) =>
    WorkoutExercise(
      exerciseId: json['exerciseId'] as String,
      notes: json['notes'] as String,
      sets: (json['sets'] as List<dynamic>)
          .map((e) => ExerciseSet.fromJson(e as Map<String, dynamic>))
          .toList(),
      restTime: json['restTime'] as int,
    );

Map<String, dynamic> _$WorkoutExerciseToJson(WorkoutExercise instance) =>
    <String, dynamic>{
      'exerciseId': instance.exerciseId,
      'notes': instance.notes,
      'sets': instance.sets.map((e) => e.toJson()).toList(),
      'restTime': instance.restTime,
    };
