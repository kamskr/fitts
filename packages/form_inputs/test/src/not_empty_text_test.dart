// ignore_for_file: prefer_const_constructors
import 'package:form_inputs/form_inputs.dart';
import 'package:test/test.dart';

void main() {
  const notEmptyTextString = 't';
  group('NotEmptyText', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final notEmptyText = NotEmptyText.pure();
        expect(notEmptyText.value, '');
        expect(notEmptyText.pure, true);
      });

      test('dirty creates correct instance', () {
        final notEmptyText = NotEmptyText.dirty(notEmptyTextString);
        expect(notEmptyText.value, notEmptyTextString);
        expect(notEmptyText.pure, false);
      });
    });

    group('validator', () {
      test('returns empty error when notEmptyText is empty', () {
        expect(
          NotEmptyText.dirty().error,
          NotEmptyTextValidationError.empty,
        );
      });

      test('is valid when notEmptyText is not empty.', () {
        expect(
          NotEmptyText.dirty(notEmptyTextString).error,
          isNull,
        );
      });
    });
  });
}
