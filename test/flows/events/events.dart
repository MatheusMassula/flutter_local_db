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