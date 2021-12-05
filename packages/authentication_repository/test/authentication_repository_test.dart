// ignore_for_file: must_be_immutable
import 'package:authentication_repository/authentication_repository.dart';
import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';

const _mockFirebaseUserUid = 'mock-uid';
const _mockFirebaseUserEmail = 'mock-email';

mixin LegacyEquality {
  @override
  bool operator ==(dynamic other) => false;

  @override
  int get hashCode => 0;
}

class MockCacheClient extends Mock implements CacheClient {}

class MockFirebaseAuth extends Mock implements firebase_auth.FirebaseAuth {}

class MockFirebaseUser extends Mock implements firebase_auth.User {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockGoogleSignInAccount extends Mock
    with LegacyEquality
    implements GoogleSignInAccount {}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

class MockUserCredential extends Mock implements firebase_auth.UserCredential {}

class FakeAuthCredential extends Fake implements firebase_auth.AuthCredential {}

class FakeAuthProvider extends Fake implements AuthProvider {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  MethodChannelFirebase.channel.setMockMethodCallHandler((call) async {
    if (call.method == 'Firebase#initializeCore') {
      return [
        {
          'name': defaultFirebaseAppName,
          'options': {
            'apiKey': '123',
            'appId': '123',
            'messagingSenderId': '123',
            'projectId': '123',
          },
          'pluginConstants': const <String, String>{},
        }
      ];
    }

    if (call.method == 'Firebase#initializeApp') {
      final arguments = call.arguments as Map<String, dynamic>;
      return <String, dynamic>{
        'name': arguments['appName'],
        'options': arguments['options'],
        'pluginConstants': const <String, String>{},
      };
    }

    return null;
  });

  TestWidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  const email = 'test@gmail.com';
  const password = 'qeqwefqwefgr';
  const user = User(
    id: _mockFirebaseUserUid,
    email: _mockFirebaseUserEmail,
  );

  group('AuthenticationRepository', () {
    late CacheClient cache;
    late firebase_auth.FirebaseAuth firebaseAuth;
    late GoogleSignIn googleSignIn;
    late AuthenticationRepository authenticationRepository;

    setUpAll(() {
      registerFallbackValue(FakeAuthCredential());
      registerFallbackValue(FakeAuthProvider());
    });

    setUp(() {
      cache = MockCacheClient();
      firebaseAuth = MockFirebaseAuth();
      googleSignIn = MockGoogleSignIn();
      authenticationRepository = AuthenticationRepository(
        cache: cache,
        firebaseAuth: firebaseAuth,
        googleSignIn: googleSignIn,
      );
    });

    test('creates FirebaseaAuth instance internally when not injected', () {
      expect(() => AuthenticationRepository(), isNot(throwsException));
    });
  });
}
