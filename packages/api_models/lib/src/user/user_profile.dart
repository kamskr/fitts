import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

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
  });

  /// Factory which converts a [Map] into a [UserProfile].
  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  /// Converts the [UserProfile] to [Map].
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  /// The email of the user.
  final String email;

  /// The photo url of the user.
  final String photoUrl;

  /// The display name of the user.
  final String displayName;

  /// An empty [UserProfile] object.
  static const empty = UserProfile(
    email: '',
    photoUrl: '',
    displayName: '',
  );

  /// Creates a copy of [UserProfile].
  UserProfile copyWith({
    String? email,
    String? photoUrl,
    String? displayName,
  }) {
    return UserProfile(
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      displayName: displayName ?? this.displayName,
    );
  }

  @override
  List<Object> get props => [email, photoUrl, displayName];

  @override
  String toString() => 'UserProfile(email: $email, '
      'photoUrl: $photoUrl, '
      'displayName: $displayName)';
}
