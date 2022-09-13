// ignore_for_file: strict_raw_type

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitts/bootstrap.dart';
import 'package:fitts/firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  const useEmulator = bool.fromEnvironment('USE_FIREBASE_EMULATOR');

  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: 'Fitts',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  if (useEmulator) {
    await _connectToFirebaseEmulator();
  }

  FirebaseFirestore.instance;

  runApp(bootstrap());
}

/// Connect to the firebase emulator for Firestore and Authentication
Future _connectToFirebaseEmulator() async {
  final localHostString = Platform.isAndroid ? '10.0.2.2' : 'localhost';

  FirebaseFirestore.instance.settings = Settings(
    host: '$localHostString:8080',
    sslEnabled: false,
    persistenceEnabled: false,
  );

  await FirebaseAuth.instance.useAuthEmulator(localHostString, 9099);
}
