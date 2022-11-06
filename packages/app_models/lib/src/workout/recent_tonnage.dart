import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recent_tonnage.g.dart';

/// {@template recent_tonnage}
/// Model representing recent tonnage lifted log for workout template.
/// {@endtemplate}
@JsonSerializable(explicitToJson: true)
class RecentTonnage extends Equatable {
  /// {@macro recent_tonnage}
  const RecentTonnage({
    required this.timePerformed,
    required this.weight,
  });

  /// Factory which converts a [Map] into a [RecentTonnage].
  factory RecentTonnage.fromJson(Map<String, dynamic> json) =>
      _$RecentTonnageFromJson(json);

  /// Converts the [RecentTonnage] to [Map].
  Map<String, dynamic> toJson() => _$RecentTonnageToJson(this);

  /// Date performed.
  final DateTime timePerformed;

  /// Weight.
  final double weight;

  /// Creates a copy of [RecentTonnage].
  RecentTonnage copyWith({
    DateTime? timePerformed,
    double? weight,
  }) {
    return RecentTonnage(
      timePerformed: timePerformed ?? this.timePerformed,
      weight: weight ?? this.weight,
    );
  }

  @override
  List<Object?> get props => [
        timePerformed,
        weight,
      ];
}
