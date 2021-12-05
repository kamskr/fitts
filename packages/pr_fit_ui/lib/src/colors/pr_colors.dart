import 'package:flutter/material.dart';

abstract class PRColors {
  static const primary = MaterialColor(0xff5063EE, {
    50: Color(0xffE9EAF2),
    400: Color(0xff808DED),
    500: Color(0xff5063EE),
    900: Color(0xff3346D4),
  });

  static const accent = MaterialColor(0xffF99543, {
    300: Color(0xffFFBE8A),
    500: Color(0xffF99543),
    900: Color(0xffD47B33),
  });

  static const secondaryAccent = MaterialColor(0xff40A076, {
    400: Color(0xff69E7A4),
    500: Color(0xff40A076),
  });

  static const black = MaterialColor(0xff23253A, {
    50: Color(0xffF5F5F5),
    100: Color(0xffDFDFE5),
    500: Color(0xff23253A),
    900: Color(0xff26262B),
  });

  static const primaryGradient1 = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: <Color>[PRColors.black, PRColors.primary],
    tileMode: TileMode.repeated,
  );

  static const primaryGradient2 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[PRColors.primary, PRColors.black],
    tileMode: TileMode.repeated,
  );

  static const primaryGradient3 = LinearGradient(
    stops: [
      0,
      0.25,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[PRColors.primary, PRColors.black],
    tileMode: TileMode.repeated,
  );

  static const primaryGradient4 = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: <Color>[PRColors.black, PRColors.primary],
    tileMode: TileMode.repeated,
  );

  static const primaryGradient5 = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: <Color>[PRColors.black, PRColors.primary],
    tileMode: TileMode.repeated,
  );
}
