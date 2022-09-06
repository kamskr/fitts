// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercise _$ExerciseFromJson(Map<String, dynamic> json) => Exercise(
      name: json['name'] as String,
      primaryMuscles: json['primaryMuscles'] as List<dynamic>,
      secondaryMuscles: json['secondaryMuscles'] as List<dynamic>,
      level: $enumDecode(_$LevelEnumMap, json['level']),
      category: $enumDecode(_$ExerciseCategoryEnumMap, json['category']),
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      tips: (json['tips'] as List<dynamic>?)?.map((e) => e as String).toList(),
      force: $enumDecodeNullable(_$ForceEnumMap, json['force']),
      mechanicType:
          $enumDecodeNullable(_$MechanicTypeEnumMap, json['mechanicType']),
      equipment: $enumDecodeNullable(_$EquipmentEnumMap, json['equipment']),
      description: json['description'] as String?,
      aliases:
          (json['aliases'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
      'name': instance.name,
      'aliases': instance.aliases,
      'primaryMuscles': instance.primaryMuscles,
      'secondaryMuscles': instance.secondaryMuscles,
      'force': _$ForceEnumMap[instance.force],
      'level': _$LevelEnumMap[instance.level]!,
      'mechanicType': _$MechanicTypeEnumMap[instance.mechanicType],
      'equipment': _$EquipmentEnumMap[instance.equipment],
      'category': _$ExerciseCategoryEnumMap[instance.category]!,
      'instructions': instance.instructions,
      'description': instance.description,
      'tips': instance.tips,
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
