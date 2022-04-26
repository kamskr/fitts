// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome to Fitts`
  String get welcomePageTitle {
    return Intl.message(
      'Welcome to Fitts',
      name: 'welcomePageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up to continue`
  String get welcomePageSubtitle {
    return Intl.message(
      'Sign Up to continue',
      name: 'welcomePageSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `SIGN UP`
  String get signUpButton {
    return Intl.message(
      'SIGN UP',
      name: 'signUpButton',
      desc: '',
      args: [],
    );
  }

  /// `SIGN IN WITH GOOGLE`
  String get signInWithGoogleButton {
    return Intl.message(
      'SIGN IN WITH GOOGLE',
      name: 'signInWithGoogleButton',
      desc: '',
      args: [],
    );
  }

  /// `SIGN IN`
  String get signInButton {
    return Intl.message(
      'SIGN IN',
      name: 'signInButton',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAccountText {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccountText',
      desc: '',
      args: [],
    );
  }

  /// `Home page`
  String get homePageTitle {
    return Intl.message(
      'Home page',
      name: 'homePageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUpPageTitle {
    return Intl.message(
      'Sign Up',
      name: 'signUpPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get signUpPageUsernameLabel {
    return Intl.message(
      'Username',
      name: 'signUpPageUsernameLabel',
      desc: '',
      args: [],
    );
  }

  /// `This username is invalid`
  String get signUpPageUsernameErrorMessage {
    return Intl.message(
      'This username is invalid',
      name: 'signUpPageUsernameErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get signUpPageEmailLabel {
    return Intl.message(
      'Email',
      name: 'signUpPageEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `This email is invalid`
  String get signUpPageEmailErrorMessage {
    return Intl.message(
      'This email is invalid',
      name: 'signUpPageEmailErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get signUpPagePasswordLabel {
    return Intl.message(
      'Password',
      name: 'signUpPagePasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `This password is invalid`
  String get signUpPagePasswordErrorMessage {
    return Intl.message(
      'This password is invalid',
      name: 'signUpPagePasswordErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `By signing up you agree to our Terms and PrivacyPolicy`
  String get signUpPageLegal {
    return Intl.message(
      'By signing up you agree to our Terms and PrivacyPolicy',
      name: 'signUpPageLegal',
      desc: '',
      args: [],
    );
  }

  /// `SIGN UP`
  String get signUpPageSignUpButton {
    return Intl.message(
      'SIGN UP',
      name: 'signUpPageSignUpButton',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signInPageTitle {
    return Intl.message(
      'Sign In',
      name: 'signInPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get signInPageEmailLabel {
    return Intl.message(
      'Email',
      name: 'signInPageEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `This email is invalid`
  String get signInPageEmailErrorMessage {
    return Intl.message(
      'This email is invalid',
      name: 'signInPageEmailErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get signInPagePasswordLabel {
    return Intl.message(
      'Password',
      name: 'signInPagePasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `This password is invalid`
  String get signInPagePasswordErrorMessage {
    return Intl.message(
      'This password is invalid',
      name: 'signInPagePasswordErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `SIGN IN`
  String get signInPageSignInButton {
    return Intl.message(
      'SIGN IN',
      name: 'signInPageSignInButton',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
