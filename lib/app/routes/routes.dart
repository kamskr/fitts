import 'package:fitts/app/app.dart';
import 'package:fitts/home/home.dart';
import 'package:fitts/welcome/welcome.dart';
import 'package:flutter/material.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.unauthenticated:
      return [WelcomePage.page()];
    default:
      return [HomePage.page()];
  }
}
