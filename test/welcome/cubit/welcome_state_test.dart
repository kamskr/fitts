// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:fitts/welcome/welcome.dart';

void main() {
  group('WelcomeState', () {
    test('supports value comparisons', () {
      expect(WelcomeState(), WelcomeState());
    });

    test('returns same object when no properties are passed', () {
      expect(WelcomeState().copyWith(), WelcomeState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        WelcomeState().copyWith(status: FormzStatus.pure),
        WelcomeState(),
      );
    });
  });
}
