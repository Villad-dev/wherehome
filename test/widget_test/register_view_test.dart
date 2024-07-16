import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wherehome/common/controllers/http_controller.dart';
import 'package:wherehome/common/inherited_http_controller.dart';
import 'package:wherehome/common/widgets/dropdown_countries_list.dart';
import 'package:wherehome/features/register/register_view.dart';

void main() {
  testWidgets('RegisterView widget test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: HttpControllerInherited(
          api: HttpController(), child: const RegisterView()),
    ));

    expect(find.text('register_help'), findsOneWidget);
    expect(find.text('register_description'), findsOneWidget);
    expect(find.byType(DropDownCountriesList), findsOneWidget);
    expect(find.byKey(const Key('Registration phone')), findsOneWidget);
    expect(find.byKey(const Key('Registration email')), findsOneWidget);
    expect(find.byKey(const Key('Registration password')), findsOneWidget);
    expect(
        find.byKey(const Key('Registration confirm password')), findsOneWidget);
    expect(find.text('register_button_text'), findsOneWidget);
  });
}
