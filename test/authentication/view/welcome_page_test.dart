import 'package:flutter_test/flutter_test.dart';
import 'package:prfit/authentication/view/welcome_page.dart';

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
