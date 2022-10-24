/// {@template text_formatters}
/// Helper class for formatting texts.
/// {@endtemplate}
class TextFormatters {
  /// Format camel case to sentence.
  static String camelToSentence(String text) {
    return text.replaceAllMapped(
      RegExp('^([a-z])|[A-Z]'),
      (Match m) => m[1] == null ? ' ${m[0]}' : m[1]!.toUpperCase(),
    );
  }
}
