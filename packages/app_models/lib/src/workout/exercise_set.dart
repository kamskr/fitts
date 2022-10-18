import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_set.g.dart';

/// {@template set}
/// Model representing individual set of a workout.
/// It an be used both for template and actual workout log.
///
/// If its defined in the template number of repetitions,
/// weight and rest time can updated when the workout is performed.
///
/// If its defined in the actual workout log,number of repetitions, weight and
///  rest time are fixed and cannot be changed.
/// {@endtemplate}
@JsonSerializable(explicitToJson: true)
class ExerciseSet extends Equatable {
  /// {@macro exercise_set}
  const ExerciseSet({
    required this.repetitions,
    required this.weight,
  });

  /// Factory which converts a [Map] into a [ExerciseSet].
  factory ExerciseSet.fromJson(Map<String, dynamic> json) =>
      _$ExerciseSetFromJson(json);

  /// Converts the [ExerciseSet] to [Map].
  Map<String, dynamic> toJson() => _$ExerciseSetToJson(this);

  /// Number of repetitions.
  final int repetitions;

  /// Weight used for the set.
  final double weight;

  /// Creates a copy of [ExerciseSet].
  ExerciseSet copyWith({
    int? repetitions,
    double? weight,
  }) {
    return ExerciseSet(
      repetitions: repetitions ?? this.repetitions,
      weight: weight ?? this.weight,
    );
  }

  @override
  List<Object> get props => [
        repetitions,
        weight,
      ];
}
