import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prfit/app/app.dart';
import 'package:prfit/home/home.dart';
import 'package:prfit/welcome/view/view.dart';

void main() {
  group('onGenerateAppViewPages', () {
    test('returns [WelcomePage] when not authenticated', () {
      expect(
        onGenerateAppViewPages(AppStatus.unauthenticated, []),
        [
          isA<MaterialPage>().having(
            (p) => p.child,
            'child',
            isA<WelcomePage>(),
          )
        ],
      );
    });

    test('returns [HomePage] when authenticated', () {
      expect(
        onGenerateAppViewPages(AppStatus.authenticated, []),
        [
          isA<MaterialPage>().having(
            (p) => p.child,
            'child',
            isA<HomePage>(),
          )
        ],
      );
    });
  });
}
