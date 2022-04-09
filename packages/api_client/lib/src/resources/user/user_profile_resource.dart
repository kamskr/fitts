import 'package:cloud_firestore/cloud_firestore.dart';

/// {@template user_profile_resource}
/// Resource which exposes APIs related to user.
/// {@endtemplate}
class UserProfileResource {
  /// {@macro user_profile_resource}
  const UserProfileResource({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

  final FirebaseFirestore _firebaseFirestore;
}
