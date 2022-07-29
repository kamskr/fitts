import 'package:api_models/api_models.dart';
import 'package:app_ui/app_ui.dart';
import 'package:authentication_client/authentication_client.dart';
import 'package:fitts/app/bloc/app_bloc.dart';
import 'package:fitts/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() {
    return const MaterialPage<void>(child: HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homePageTitle),
      ),
      body: const HomeBody(),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppBloc>().state;

    return Column(
      children: [
        const Text('Dashboard'),
        const SizedBox(height: 100),
        Text(state.userProfile.profileStatus == ProfileStatus.active
            ? 'User active'
            : 'User not active'),
        Text(state.userProfile.email),
        Text(state.userProfile.displayName),
        Text(state.userProfile.gender == Gender.male ? 'Male' : 'Female'),
        Text(state.userProfile.height.toString()),
        Text(state.userProfile.weight.toString()),
        Center(
          child: AppButton.primary(
            child: const Text('Sign out'),
            onPressed: () {
              context.read<AuthenticationClient>().signOut();
            },
          ),
        ),
      ],
    );
  }
}
