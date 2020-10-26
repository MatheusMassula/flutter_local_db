import 'package:flutter/material.dart';
import 'package:flutter_local_db/pages/dashboard.dart';
import 'package:flutter_test/flutter_test.dart';

import 'matchers.dart';

void main() {
  testWidgets('should display bytebank logo when dashboard is opened', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final Finder logoImage = find.byType(Image);
    expect(logoImage, findsOneWidget);
  });

  testWidgets('Should display the the transfer feature when the Dashboard is opened', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final tranferFeatureItem = find.byWidgetPredicate(
      (widget) => dashBoadCardMatcher(widget: widget, title: 'Transfer', icon: Icons.monetization_on)
    );
    expect(tranferFeatureItem, findsOneWidget);
  });

  testWidgets('Should display the the transaction feed feature when the Dashboard is opened', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final tranferFeatureItem = find.byWidgetPredicate(
      (widget) => dashBoadCardMatcher(widget: widget, title: 'Transactions', icon: Icons.description)
    );
    expect(tranferFeatureItem, findsOneWidget);
  });
}