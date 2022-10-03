// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overall_best.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverallBest _$OverallBestFromJson(Map<String, dynamic> json) => OverallBest(
      weight: (json['weight'] as num).toDouble(),
      repetitions: json['repetitions'] as int,
    );

Map<String, dynamic> _$OverallBestToJson(OverallBest instance) =>
    <String, dynamic>{
      'weight': instance.weight,
      'repetitions': instance.repetitions,
    };
