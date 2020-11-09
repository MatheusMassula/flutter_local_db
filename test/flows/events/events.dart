import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../matchers/matchers.dart';

Future<void> tapOnTransferItem(WidgetTester tester) async {
  final transferFeatureItem = find.byWidgetPredicate((widget) =>
    dashBoadCardMatcher(
      widget: widget, title: 'Transfer', icon: Icons.monetization_on
    ));
  expect(transferFeatureItem, findsOneWidget);
  return tester.tap(transferFeatureItem);
}

Future<void> tapOnAddContactFloatButton(WidgetTester tester) async {
  final addContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
  expect(addContact, findsOneWidget);
  return tester.tap(addContact);
}

Future<void> fillTextFieldByLabelText({
  @required WidgetTester tester,
  @required String labelText,
  @required String text
}) async {
  final textField = find.byWidgetPredicate((widget) =>
    textFieldByLabelTextMatcher(
      widget: widget,
      labelText: labelText
    )
  );
  expect(textField, findsOneWidget);
  return tester.enterText(textField, text);
}

Future tapOnWidgetWithText({
  @required WidgetTester tester,
  @required Type type,
  @required String text
}) async {
  final widgetToBeTaped = find.widgetWithText(type, text);
  expect(widgetToBeTaped, findsOneWidget);
  await tester.tap(widgetToBeTaped);
}