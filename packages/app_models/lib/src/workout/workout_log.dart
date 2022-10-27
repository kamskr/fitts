import 'package:app_models/app_models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'workout_log.g.dart';

/// {@template workout_log}
/// Model representing individual workout log.
/// Workout log is created when the workout is performed.
/// {@endtemplate}
@JsonSerializable(explicitToJson: true)
class WorkoutLog extends Equatable {
  /// {@macro workout_log}
  const WorkoutLog({
    required this.id,
    required this.duration,
    required this.datePerformed,
    required this.workoutTemplate,
    required this.exercises,
  });

  /// Factory which converts a [Map] into a [WorkoutLog].
  factory WorkoutLog.fromJson(Map<String, dynamic> json) =>
      _$WorkoutLogFromJson(json);

  /// Converts the [WorkoutLog] to [Map].
  Map<String, dynamic> toJson() => _$WorkoutLogToJson(this);

  /// Workout log id.
  final String id;

  /// Workout duration in seconds.
  final int duration;

  /// Date when the workout was performed.
  final DateTime datePerformed;

  /// [WorkoutTemplate] used for this workout.
  final WorkoutTemplate workoutTemplate;

  /// List of exercises performed in the workout.
  final List<WorkoutExercise> exercises;

  /// Get total weight performed in this exercise.
  double get totalWeight => exercises.fold(
        0,
        (previousValue, element) =>
            previousValue +
            element.sets.fold<double>(
              0,
              (previousValue, element) =>
                  previousValue + (element.weight * element.repetitions),
            ),
      );

  /// Returns average rest time in seconds.
  int get averageRestTime {
    if (exercises.isEmpty) {
      return 0;
    }
    return exercises.fold<int>(
          0,
          (previousValue, element) => previousValue + element.restTime,
        ) ~/
        exercises.length;
  }

  /// Creates a copy of [WorkoutLog].
  WorkoutLog copyWith({
    String? id,
    int? duration,
    DateTime? datePerformed,
    WorkoutTemplate? workoutTemplate,
    List<WorkoutExercise>? exercises,
  }) {
    return WorkoutLog(
      id: id ?? this.id,
      duration: duration ?? this.duration,
      datePerformed: datePerformed ?? this.datePerformed,
      workoutTemplate: workoutTemplate ?? this.workoutTemplate,
      exercises: exercises ?? this.exercises,
    );
  }

  @override
  List<Object> get props => [
        id,
        duration,
        datePerformed,
        workoutTemplate,
        exercises,
      ];

  /// empty workout log
  static WorkoutLog empty = WorkoutLog(
    id: '',
    duration: 0,
    datePerformed: DateTime(0),
    workoutTemplate: WorkoutTemplate.empty,
    exercises: const [],
  );
}
