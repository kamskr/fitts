import 'package:api_models/api_models.dart';
import 'package:app_ui/app_ui.dart';
import 'package:authentication_client/authentication_client.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:fitts/app/app.dart';
import 'package:fitts/welcome/welcome.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

// ignore: must_be_immutable
class MockUser extends Mock implements User {}

class MockAuthenticationClient extends Mock implements AuthenticationClient {}

class MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {}

void main() {
  group('App', () {
    late AuthenticationClient authenticationClient;

    setUp(() {
      authenticationClient = MockAuthenticationClient();

      when(() => authenticationClient.user).thenAnswer(
        (_) => Stream.value(User.empty),
      );
    });

    testWidgets('renders AppView', (tester) async {
      await tester.pumpApp(
        App(lightThemeData: AppTheme.lightTheme),
        authenticationClient: authenticationClient,
      );
      await tester.pump();
      expect(find.byType(AppView), findsOneWidget);
    });
  });

  group('AppView', () {
    late AppBloc appBloc;

    setUp(() {
      appBloc = MockAppBloc();
    });

    testWidgets('navigates to WelcomeScreen when unauthenticated',
        (tester) async {
      when(() => appBloc.state).thenReturn(
        AppState.initial(
          userProfile: UserProfile.empty,
          status: AppStatus.unauthenticated,
        ),
      );
      await tester.pumpApp(
        AppView(lightThemeData: AppTheme.lightTheme),
        appBloc: appBloc,
      );
      await tester.pumpAndSettle();
      expect(find.byType(WelcomePage), findsOneWidget);
    });
  });
}
