import 'package:flutter_test/flutter_test.dart';
import 'package:google_signin/main.dart';

void main() {
  testWidgets('Missing Firebase setup displays instructions', (tester) async {
    await tester.pumpWidget(
      const FirebaseSetupApp(
        message: 'Run flutterfire configure and restart the app.',
      ),
    );
    expect(find.text('Firebase setup required'), findsOneWidget);
    expect(
      find.text('Run flutterfire configure and restart the app.'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}
