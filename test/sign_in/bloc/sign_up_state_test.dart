// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:prfit/sign_in/sign_in.dart';

void main() {
  group('SignInState', () {
    test('supports value comparisons', () {
      expect(SignInState(), SignInState());
    });

    test('returns same object when no properties are passed', () {
      expect(SignInState().copyWith(), SignInState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        SignInState().copyWith(status: FormzStatus.pure),
        SignInState(),
      );
    });
  });
}
