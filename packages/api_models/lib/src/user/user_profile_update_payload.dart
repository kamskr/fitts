import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile_update_payload.g.dart';

/// {@template user_profile_update_payload}
/// Represents the payload for updating user profile.
/// {@endtemplate}
@JsonSerializable()
class UserProfileUpdatePayload extends Equatable {
  /// {@macro user_profile_update_payload}
  const UserProfileUpdatePayload({
    required this.email,
    required this.photoUrl,
    required this.displayName,
    required this.goal,
    required this.gender,
    required this.dateOfBirth,
    required this.height,
    required this.weight,
  });

  /// Factory which converts a [Map] into a [UserProfileUpdatePayload].
  factory UserProfileUpdatePayload.fromJson(Map<String, dynamic> json) =>
      _$UserProfileUpdatePayloadFromJson(json);

  /// Converts the [UserProfileUpdatePayload] to [Map].
  Map<String, dynamic> toJson() => _$UserProfileUpdatePayloadToJson(this);

  /// The email of the user.
  @JsonKey(name: 'email')
  final String email;

  /// The photo url of the user.
  @JsonKey(name: 'photoUrl')
  final String photoUrl;

  /// The display name of the user.
  @JsonKey(name: 'displayName')
  final String displayName;

  /// Current goal of this user (loose weight, gain weight, etc).
  @JsonKey(name: 'goal')
  final String goal;

  /// Gender of the user.
  @JsonKey(name: 'gender')
  final String gender;

  /// Birth date of the user.
  @JsonKey(name: 'dateOfBirth')
  final DateTime dateOfBirth;

  /// Height of the user.
  @JsonKey(name: 'height')
  final int height;

  /// Weight if the user.
  @JsonKey(name: 'weight')
  final double weight;

  /// An empty [UserProfileUpdatePayload] object.
  static UserProfileUpdatePayload empty = UserProfileUpdatePayload(
    email: '',
    photoUrl: '',
    displayName: '',
    goal: '',
    gender: '',
    dateOfBirth: DateTime.now(),
    height: 0,
    weight: 0,
  );

  /// Creates a copy of [UserProfileUpdatePayload].
  UserProfileUpdatePayload copyWith({
    String? email,
    String? photoUrl,
    String? displayName,
    String? goal,
    String? gender,
    DateTime? dateOfBirth,
    int? height,
    double? weight,
  }) {
    return UserProfileUpdatePayload(
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      displayName: displayName ?? this.displayName,
      goal: goal ?? this.goal,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      height: height ?? this.height,
      weight: weight ?? this.weight,
    );
  }

  @override
  List<Object> get props {
    return [
      email,
      photoUrl,
      displayName,
      goal,
      gender,
      dateOfBirth,
      height,
      weight,
    ];
  }

  @override
  String toString() {
    return 'UserProfileUpdatePayload(email: $email, photoUrl: $photoUrl, displayName: $displayName, goal: $goal, gender: $gender, dateOfBirth: $dateOfBirth, height: $height, weight: $weight)';
  }
}
