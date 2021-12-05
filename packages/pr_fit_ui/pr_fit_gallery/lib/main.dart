import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ignore: public_member_api_docs
class MyApp extends StatelessWidget {
  // ignore: public_member_api_docs
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Gallery',
          ),
        ),
        body: const Text('Gallery'),
      ),
    );
  }
}
