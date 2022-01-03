import 'package:flutter_test/flutter_test.dart';
import 'package:prfit/authentication/authentication.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('WelcomePage', () {
    testWidgets('renders properly', (tester) async {
      await tester.pumpApp(
        const WelcomePage(),
      );

      expect(find.byType(WelcomeView), findsOneWidget);
    });
  });
}
