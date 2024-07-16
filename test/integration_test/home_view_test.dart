import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:wherehome/features/home/widgets/search_widget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('SearchHomeWidget Integration Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SearchHomeWidget(
            onSearch: (query) {},
          ),
        ),
      ),
    );
    final finder = find.byType(SearchHomeWidget);
    expect(finder, findsOneWidget);
    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);
    await tester.enterText(textFieldFinder, 'Sample search query');
    expect(find.text('Sample search query'), findsOneWidget);
    await tester.testTextInput.receiveAction(TextInputAction.done);
  });
}
