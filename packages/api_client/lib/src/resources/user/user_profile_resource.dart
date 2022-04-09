import 'package:firebase_database/firebase_database.dart';

/// {@template user_profile_resource}
/// Resource which exposes APIs related to user.
/// {@endtemplate}
class UserProfileResource {
  /// {@macro user_profile_resource}
  const UserProfileResource({
    required FirebaseDatabase primaryDatabase,
  }) : _primaryDatabase = primaryDatabase;

  final FirebaseDatabase _primaryDatabase;
}
