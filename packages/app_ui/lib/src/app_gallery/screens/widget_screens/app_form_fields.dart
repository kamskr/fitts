// ignore_for_file: public_member_api_docs
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
          gradient: context.appColorScheme.primaryGradient2,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: const [
              AppTextField(
                labelText: 'Email',
              ),
              SizedBox(
                height: 20,
              ),
              AppTextField(
                labelText: 'Password',
                inputType: AppTextFieldType.password,
              ),
              SizedBox(
                height: 20,
              ),
              AppTextField(
                labelText: 'Password',
                inputType: AppTextFieldType.password,
                errorText: 'Please enter your password',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
