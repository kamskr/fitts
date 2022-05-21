import 'package:equatable/equatable.dart';

/// {@template gender}
/// Represents gender of the user
/// {@endtemplate}
enum Gender {
  /// Male
  male,

  /// Female
  female,
}

/// {@template profile_status}
/// Profile status represent current status of user's profile
/// {@endtemplate}
enum ProfileStatus {
  /// Profile required onboarding
  onboardingRequired,

  /// Profile active
  active,

  /// Profile blocked
  blocked
}

/// A class used for storing gender string representation.
abstract class GenderStringValue {
  /// String value representing [Gender.male]
  static const male = 'male';

  /// String value representing [Gender.female]
  static const female = 'female';
}

/// A class used for storing profileStatus string representation.
abstract class ProfileStatusStringValue {
  /// String value representing [ProfileStatus.onboardingRequired]
  static const onboardingRequired = 'onboardingRequired';

  /// String value representing [ProfileStatus.active]
  static const active = 'active';

  /// String value representing [ProfileStatus.blocked]
  static const blocked = 'blocked';
}

/// {@template user_profile}
/// A model representing user profile stored in the firestore realtime database.
///
/// This model is an extension to the user information which
/// are contained in the firebase auth process.
/// {@endtemplate}

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
    required this.profileStatus,
  });

  /// The email of the user.
  final String email;

  /// The photo url of the user.
  final String photoUrl;

  /// The display name of the user.
  final String displayName;

  /// Current goal of this user (loose weight, gain weight, etc).
  final String goal;

  /// Gender of the user.
  final Gender gender;

  /// Birth date of the user.
  final DateTime dateOfBirth;

  /// Height of the user.
  final int height;

  /// Weight if the user.
  final double weight;

  /// If user is new - require profile setup.
  final ProfileStatus profileStatus;

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
    profileStatus: ProfileStatus.active,
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
    ProfileStatus? profileStatus,
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
      profileStatus: profileStatus ?? this.profileStatus,
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
      profileStatus,
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
        'profileStatus: $profileStatus '
        ')';
  }
}
