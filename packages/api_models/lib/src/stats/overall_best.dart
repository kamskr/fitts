import 'package:equatable/equatable.dart';

/// {@template overall_best}
/// A model representing overall best result for the exercise.
/// {@endtemplate}
class OverallBest extends Equatable {
  /// {@macro overall_best}
  const OverallBest({
    required this.weight,
    required this.repetitions,
  });

  /// Weight used for the best result.
  final double weight;

  /// Number of repetitions used for the best result.
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
