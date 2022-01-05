import 'package:flutter/material.dart';
import 'package:prfit/app/app.dart';
import 'package:prfit/home/home.dart';
import 'package:prfit/welcome/welcome.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.unauthenticated:
      return [WelcomePage.page()];
    default:
      return [HomePage.page()];
  }
}
