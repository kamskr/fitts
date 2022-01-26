import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class AppFormFields extends StatelessWidget {
  const AppFormFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Form Fields'),
      ),
      body: DecoratedBox(
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient2,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: const [
              AppTextField(labelText: 'Test'),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
