import 'package:flutter/material.dart';
import 'package:fitts/app/app.dart';
import 'package:fitts/home/home.dart';
import 'package:fitts/welcome/welcome.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.unauthenticated:
      return [WelcomePage.page()];
    default:
      return [HomePage.page()];
  }
}
