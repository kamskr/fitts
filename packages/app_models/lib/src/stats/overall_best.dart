import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'overall_best.g.dart';

/// {@template overall_best}
/// A model representing overall best result for the exercise.
/// {@endtemplate}
@JsonSerializable(explicitToJson: true)
class OverallBest extends Equatable {
  /// {@macro overall_best}
  const OverallBest({
    required this.weight,
    required this.repetitions,
  });

  /// Factory which converts a [Map] into a [OverallBest].
  factory OverallBest.fromJson(Map<String, dynamic> json) =>
      _$OverallBestFromJson(json);

  /// Converts the [OverallBest] to [Map].
  Map<String, dynamic> toJson() => _$OverallBestToJson(this);

  /// Weight used for the best result.
  @JsonKey(name: 'weight')
  final double weight;

  /// Number of repetitions used for the best result.
  @JsonKey(name: 'repetitions')
  final int repetitions;
  @override
  List<Object> get props => [weight, repetitions];

  /// Creates a copy of [OverallBest].
  OverallBest copyWith({
    double? weight,
    int? repetitions,
  }) {
    return OverallBest(
      weight: weight ?? this.weight,
      repetitions: repetitions ?? this.repetitions,
    );
  }
}
