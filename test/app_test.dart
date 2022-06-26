import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:number_trivia/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setupSingletons();

  group("integration testing", () {
    testWidgets("get concrete number trivia", (tester) async {
      await tester.pumpWidget(const NumberTriviaApp());

      await tester.enterText(find.byType(TextField), "42");

      await tester.tap(find.byType(MaterialButton).last);

      await tester.pump(const Duration(seconds: 3));

      expect(find.text("42", findRichText: false), findsOneWidget);
    });

    testWidgets("get random number trivia", (tester) async {
      await tester.pumpWidget(const NumberTriviaApp());

      await tester.tap(find.byType(MaterialButton).last);

      await tester.pump(const Duration(seconds: 3));

      expect(find.textContaining(RegExp(r"^\d+$"), findRichText: false), findsOneWidget);
    });
  });
}
