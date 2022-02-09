import 'package:authentication_client/authentication_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prfit/sign_up/sign_up.dart';

import '../../helpers/pump_app.dart';

class MockAuthenticationClient extends Mock implements AuthenticationClient {}

void main() {
  group('SignUpPage', () {
    testWidgets('is routable.', (tester) async {
      expect(SignUpPage.route(), isA<MaterialPageRoute>());
    });

    testWidgets('renders properly.', (tester) async {
      await tester.pumpApp(const SignUpPage());

      expect(find.byType(SignUpPage), findsOneWidget);
    });
  });
}
