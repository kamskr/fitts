import 'package:api_client/api_client.dart';
import 'package:authentication_client/authentication_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitts/app/app.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_profile_repository/user_profile_repository.dart';

Widget bootstrap(Widget app) {
  final firestore = FirebaseFirestore.instance;

  final _authenticationClient = AuthenticationClient();
  final _apiClient = ApiClient(firebaseFirestore: firestore);

  return MultiRepositoryProvider(
    providers: [
      RepositoryProvider.value(value: _authenticationClient),
      RepositoryProvider(
        create: (_) => UserProfileRepository(_apiClient),
      ),
    ],
    child: App(),
  );
}
