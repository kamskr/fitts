// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseSet _$ExerciseSetFromJson(Map<String, dynamic> json) => ExerciseSet(
      repetitions: json['repetitions'] as int,
      weight: (json['weight'] as num).toDouble(),
      isDone: json['isDone'] as bool?,
    );

Map<String, dynamic> _$ExerciseSetToJson(ExerciseSet instance) =>
    <String, dynamic>{
      'repetitions': instance.repetitions,
      'weight': instance.weight,
      'isDone': instance.isDone,
    };
