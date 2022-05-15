import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile_data.g.dart';

/// {@template user_profile}
/// A model representing user profile stored in the firestore realtime database.
///
/// This model is an extension to the user information which
/// are contained in the firebase auth process.
/// {@endtemplate}
@JsonSerializable()
class UserProfileData extends Equatable {
  /// {@macro user_profile}
  const UserProfileData({
    required this.email,
    this.photoUrl,
    this.displayName,
    this.goal,
    this.gender,
    this.dateOfBirth,
    this.height,
    this.weight,
    this.isNewUser,
  });

  /// Factory which converts a [Map] into a [UserProfileData].
  factory UserProfileData.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDataFromJson(json);

  /// Converts the [UserProfileData] to [Map].
  Map<String, dynamic> toJson() => _$UserProfileDataToJson(this);

  /// The email of the user.
  @JsonKey(name: 'email')
  final String email;

  /// The photo url of the user.
  @JsonKey(name: 'photoUrl')
  final String? photoUrl;

  /// The display name of the user.
  @JsonKey(name: 'displayName')
  final String? displayName;

  /// Current goal of this user (loose weight, gain weight, etc).
  @JsonKey(name: 'goal')
  final String? goal;

  /// Gender of the user.
  @JsonKey(name: 'gender')
  final String? gender;

  /// Birth date of the user.
  @JsonKey(name: 'dateOfBirth')
  final DateTime? dateOfBirth;

  /// Height of the user.
  @JsonKey(name: 'height')
  final int? height;

  /// Weight if the user.
  @JsonKey(name: 'weight')
  final double? weight;

  /// If user is new - require profile setup.
  @JsonKey(name: 'isNewUser')
  final bool? isNewUser;

  /// An empty [UserProfileData] object.
  static UserProfileData empty = const UserProfileData(
    email: 'email',
  );

  /// Creates a copy of [UserProfileData].
  UserProfileData copyWith({
    String? email,
    String? photoUrl,
    String? displayName,
    String? goal,
    String? gender,
    DateTime? dateOfBirth,
    int? height,
    double? weight,
    bool? isNewUser,
  }) {
    return UserProfileData(
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      displayName: displayName ?? this.displayName,
      goal: goal ?? this.goal,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      isNewUser: isNewUser ?? this.isNewUser,
    );
  }

  @override
  List<Object?> get props {
    return [
      email,
      photoUrl,
      displayName,
      goal,
      gender,
      dateOfBirth,
      height,
      weight,
      isNewUser,
    ];
  }

  @override
  String toString() {
    return 'UserProfileData('
        'email: $email, '
        'photoUrl: $photoUrl, '
        'displayName: $displayName, '
        'goal: $goal, '
        'gender: $gender, '
        'dateOfBirth: $dateOfBirth, '
        'height: $height, '
        'weight: $weight, '
        'isNewUser: $isNewUser '
        ')';
  }
}
