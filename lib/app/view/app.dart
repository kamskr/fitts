import 'package:authentication_client/authentication_client.dart';
import 'package:fitts/app/app.dart';
import 'package:fitts/l10n/l10n.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:user_profile_repository/user_profile_repository.dart';

/// {@template app}
/// Root app widget.
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({
    Key? key,
    required this.lightThemeData,
    // required this.darkThemeData,
  }) : super(key: key);

  /// Theme data for the light theme.
  final ThemeData lightThemeData;
  // final AppThemeData darkThemeData;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (_) => AppBloc(
            authenticationClient: context.read<AuthenticationClient>(),
            userProfileRepository: context.read<UserProfileRepository>(),
          ),
        ),
      ],
      child: AppView(lightThemeData: lightThemeData),
    );
  }
}

@visibleForTesting
// ignore: public_member_api_docs
class AppView extends StatelessWidget {
// ignore: public_member_api_docs
  const AppView({
    Key? key,
    required this.lightThemeData,
  }) : super(key: key);

  /// Theme data for the light theme.
  final ThemeData lightThemeData;
  // final AppThemeData darkThemeData;

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    // const themeMode = ThemeMode.system;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
