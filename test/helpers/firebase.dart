// ignore_for_file: avoid_dynamic_calls
// ignore_for_file: implicit_dynamic_map_literal

import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

typedef Callback = void Function(MethodCall call);

void setupFirebaseAuthMocks([Callback? customHandlers]) {
  TestWidgetsFlutterBinding.ensureInitialized();

  setupFirebaseCoreMocks();
}

class MockFirebaseApp implements TestFirebaseCoreHostApi {
  @override
  Future<PigeonInitializeResponse> initializeApp(
    String appName,
    PigeonFirebaseOptions initializeAppRequest,
  ) async {
    return PigeonInitializeResponse(
      name: appName,
      options: PigeonFirebaseOptions(
        apiKey: '123',
        projectId: '123',
        appId: '123',
        messagingSenderId: '123',
      ),
      pluginConstants: {},
    );
  }

  @override
  Future<List<PigeonInitializeResponse?>> initializeCore() async {
    return [
      PigeonInitializeResponse(
        name: defaultFirebaseAppName,
        options: PigeonFirebaseOptions(
          apiKey: '123',
          projectId: '123',
          appId: '123',
          messagingSenderId: '123',
        ),
        pluginConstants: {},
      )
    ];
  }

  @override
  Future<PigeonFirebaseOptions> optionsFromResource() async {
    return PigeonFirebaseOptions(
      apiKey: '123',
      projectId: '123',
      appId: '123',
      messagingSenderId: '123',
    );
  }
}

/// [setupFirebaseCoreMocks] can be used to mock the FirebasePlatform.
///
/// If you need to customize the mock,
/// you can implement [TestFirebaseCoreHostApi]
/// and call `TestFirebaseCoreHostApi.setup(MyMock());`
void setupFirebaseCoreMocks() {
  TestFirebaseCoreHostApi.setup(MockFirebaseApp());
}

Future<T> neverEndingFuture<T>() async {
  // ignore: literal_only_boolean_expressions
  while (true) {
    await Future<dynamic>.delayed(const Duration(minutes: 5));
  }
}
