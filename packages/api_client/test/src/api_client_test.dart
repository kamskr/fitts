import 'package:api_client/api_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  group('ApiClient', () {
    late FirebaseFirestore firebaseFirestore;

    setUp(() {
      firebaseFirestore = MockFirebaseFirestore();
    });

    test('can be instantiated.', () {
      expect(
        ApiClient(
          firebaseFirestore: firebaseFirestore,
        ),
        isNotNull,
      );
    });
  });
}
