// ignore_for_file: unused_field

import 'package:api_client/api_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

/// {@template firebase_database_options}
/// [FirebaseDatabase] configuration which provides links to all the instances
/// of databases used in the application.
/// {@endtemplate}
class FirebaseDatabaseOptions {
  /// {@macro firebase_database_options}
  FirebaseDatabaseOptions._({
    required this.primaryDatabaseUrl,
  });

  /// {@macro firebase_database_options}
  FirebaseDatabaseOptions.development()
      : this._(
          primaryDatabaseUrl: 'fitts-eceb5.web.app',
        );

  /// URL to the primary Firebase Realtime Database.
  final String primaryDatabaseUrl;
}

/// {@template api_client}
/// A client to retrieve information from API.
/// {@endtemplate}
class ApiClient {
  /// {@macro api_client}
  ApiClient({
    required FirebaseFirestore firebaseFirestore,
    required FirebaseDatabase primaryDatabase,
  })  : _primaryDatabase = primaryDatabase,
        _firebaseFirestore = firebaseFirestore;

  final FirebaseDatabase _primaryDatabase;

  final FirebaseFirestore _firebaseFirestore;

  /// {@macro user_profile_resource}
  late final UserProfileResource userProfileResource = UserProfileResource(
    primaryDatabase: _primaryDatabase,
  );
}
