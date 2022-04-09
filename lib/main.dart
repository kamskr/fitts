import 'dart:developer';

import 'package:authentication_client/authentication_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/view/app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: 'Fitts',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  FirebaseFirestore.instance;

  final _authenticationClient = AuthenticationClient();

  BlocOverrides.runZoned(
    () {
      runApp(App(authenticationClient: _authenticationClient));
    },
    blocObserver: AppBlocObserver(),
  );
}

class AppBlocObserver extends BlocObserver {
  AppBlocObserver();

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log('onTransition ${bloc.runtimeType}: $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('onError ${bloc.runtimeType}', error: error, stackTrace: stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange $change');
  }
}
