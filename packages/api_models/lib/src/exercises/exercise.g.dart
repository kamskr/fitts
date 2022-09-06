// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercise _$ExerciseFromJson(Map<String, dynamic> json) => Exercise(
      name: json['name'] as String,
      primaryMuscles: (json['primaryMuscles'] as List<dynamic>)
          .map((e) => $enumDecode(_$MuscleEnumMap, e))
          .toList(),
      secondaryMuscles: (json['secondaryMuscles'] as List<dynamic>)
          .map((e) => $enumDecode(_$MuscleEnumMap, e))
          .toList(),
      level: $enumDecode(_$LevelEnumMap, json['level']),
      category: $enumDecode(_$ExerciseCategoryEnumMap, json['category']),
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      tips: (json['tips'] as List<dynamic>?)?.map((e) => e as String).toList(),
      force: $enumDecodeNullable(_$ForceEnumMap, json['force']),
      mechanicType:
          $enumDecodeNullable(_$MechanicTypeEnumMap, json['mechanic']),
      equipment: $enumDecodeNullable(_$EquipmentEnumMap, json['equipment']),
      description: json['description'] as String?,
      aliases:
          (json['aliases'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
      'name': instance.name,
      'aliases': instance.aliases,
      'primaryMuscles':
          instance.primaryMuscles.map((e) => _$MuscleEnumMap[e]!).toList(),
      'secondaryMuscles':
          instance.secondaryMuscles.map((e) => _$MuscleEnumMap[e]!).toList(),
      'force': _$ForceEnumMap[instance.force],
      'level': _$LevelEnumMap[instance.level]!,
      'mechanic': _$MechanicTypeEnumMap[instance.mechanicType],
      'equipment': _$EquipmentEnumMap[instance.equipment],
      'category': _$ExerciseCategoryEnumMap[instance.category]!,
      'instructions': instance.instructions,
      'description': instance.description,
      'tips': instance.tips,
    };

const _$MuscleEnumMap = {
  Muscle.abdominals: 'abdominals',
  Muscle.hamstrings: 'hamstrings',
  Muscle.calves: 'calves',
  Muscle.shoulders: 'shoulders',
  Muscle.adductors: 'adductors',
  Muscle.glutes: 'glutes',
  Muscle.quadriceps: 'quadriceps',
  Muscle.biceps: 'biceps',
  Muscle.forearms: 'forearms',
  Muscle.abductors: 'abductors',
  Muscle.triceps: 'triceps',
  Muscle.chest: 'chest',
  Muscle.lowerBack: 'lowerBack',
  Muscle.traps: 'traps',
  Muscle.middleBack: 'middleBack',
  Muscle.lats: 'lats',
  Muscle.neck: 'neck',
};

const _$LevelEnumMap = {
  Level.beginner: 'beginner',
  Level.intermediate: 'intermediate',
  Level.advanced: 'advanced',
};

const _$ExerciseCategoryEnumMap = {
  ExerciseCategory.strength: 'strength',
  ExerciseCategory.stretching: 'stretching',
  ExerciseCategory.plyometrics: 'plyometrics',
  ExerciseCategory.strongman: 'strongman',
  ExerciseCategory.powerlifting: 'powerlifting',
  ExerciseCategory.cardio: 'cardio',
  ExerciseCategory.olympicWeightlifting: 'olympicWeightlifting',
  ExerciseCategory.crossfit: 'crossfit',
  ExerciseCategory.weightedBodyweight: 'weightedBodyweight',
  ExerciseCategory.assistedBodyweight: 'assistedBodyweight',
};

const _$ForceEnumMap = {
  Force.pull: 'pull',
  Force.push: 'push',
  Force.static: 'static',
};

const _$MechanicTypeEnumMap = {
  MechanicType.compound: 'compound',
  MechanicType.isolation: 'isolation',
};

const _$EquipmentEnumMap = {
  Equipment.body: 'body',
  Equipment.machine: 'machine',
  Equipment.kettlebells: 'kettlebells',
  Equipment.dumbbell: 'dumbbell',
  Equipment.cable: 'cable',
  Equipment.barbell: 'barbell',
  Equipment.bands: 'bands',
  Equipment.medicineBall: 'medicineBall',
  Equipment.exerciseBall: 'exerciseBall',
  Equipment.eZCurlBar: 'eZCurlBar',
  Equipment.foamRoll: 'foamRoll',
};
