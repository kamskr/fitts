import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

/// {@template gender}
/// Represents gender of the user
/// {@endtemplate}
enum Gender {
  /// Male
  male,

  /// Female
  female,
}

/// {@template user_profile}
/// A model representing user profile stored in the firestore realtime database.
///
/// This model is an extension to the user information which
/// are contained in the firebase auth process.
/// {@endtemplate}
@JsonSerializable()
class UserProfile extends Equatable {
  /// {@macro user_profile}
  const UserProfile({
    required this.email,
    required this.photoUrl,
    required this.displayName,
    required this.goal,
    required this.gender,
    required this.dateOfBirth,
    required this.height,
    required this.weight,
    required this.isNewUser,
  });

  /// Factory which converts a [Map] into a [UserProfile].
  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  /// Converts the [UserProfile] to [Map].
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

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
  final Gender gender;

  /// Birth date of the user.
  @JsonKey(name: 'dateOfBirth')
  final DateTime dateOfBirth;

  /// Height of the user.
  @JsonKey(name: 'height')
  final int height;

  /// Weight if the user.
  @JsonKey(name: 'weight')
  final double weight;

  /// If user is new - require profile setup.
  @JsonKey(name: 'isNewUser')
  final bool isNewUser;

  /// An empty [UserProfile] object.
  static UserProfile empty = UserProfile(
    email: '',
    photoUrl: '',
    displayName: '',
    goal: '',
    gender: Gender.male,
    dateOfBirth: DateTime.now(),
    height: 0,
    weight: 0,
    isNewUser: true,
  );

  /// Creates a copy of [UserProfile].
  UserProfile copyWith({
    String? email,
    String? photoUrl,
    String? displayName,
    String? goal,
    Gender? gender,
    DateTime? dateOfBirth,
    int? height,
    double? weight,
    bool? isNewUser,
  }) {
    return UserProfile(
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
      isNewUser,
    ];
  }

  @override
  String toString() {
    return 'UserProfile('
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
