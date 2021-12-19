import 'package:equatable/equatable.dart';

/// {@template user}
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.id,
    this.email,
    this.name,
    this.photo,
    this.isNewUser = true,
    this.isAnonymous = true,
  });

  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String? name;

  /// Url for the current user's photo.
  final String? photo;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  /// Whether the current user is a first time user.
  final bool isNewUser;

  /// Wether the current user is anonymous.
  final bool isAnonymous;

  @override
  List<Object?> get props => [email, id, name, photo];
}
