import 'package:authentication_client/authentication_client.dart';
import 'package:fitts/app/app.dart';
import 'package:fitts/l10n/l10n.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_profile_repository/user_profile_repository.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.lightThemeData,
    // required this.darkThemeData,
  }) : super(key: key);

  final ThemeData lightThemeData;
  // final AppThemeData darkThemeData;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppBloc(
        authenticationClient: context.read<AuthenticationClient>(),
        userProfileRepository: context.read<UserProfileRepository>(),
      ),
      child: AppView(lightThemeData: lightThemeData),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    Key? key,
    required this.lightThemeData,
  }) : super(key: key);

  final ThemeData lightThemeData;
  // final AppThemeData darkThemeData;

  @override
  Widget build(BuildContext context) {
    // const themeMode = ThemeMode.system;

    return MaterialApp(
      title: 'Fitts',
      theme: lightThemeData,
      // darkTheme: darkThemeData.materialThemeData,
      // themeMode: themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: FlowBuilder<AppState>(
        state: context.select((AppBloc bloc) => bloc.state),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
