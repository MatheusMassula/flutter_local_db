import 'package:flutter/material.dart';
import 'package:flutter_local_db/pages/dashboard.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';

void main() {
  MockContactDao mockContactDao;

  setUp(() async {
    mockContactDao = MockContactDao();
  });

  group('When Dashboard is opne', () {
    testWidgets('should display bytebank logo', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Dashboard(contactDao: mockContactDao)));
      final Finder logoImage = find.byType(Image);
      expect(logoImage, findsOneWidget);
    });

    testWidgets('Should display the the transfer feature', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Dashboard(contactDao: mockContactDao)));
      final tranferFeatureItem = find.byWidgetPredicate(
        (widget) => dashBoadCardMatcher(widget: widget, title: 'Transfer', icon: Icons.monetization_on)
      );
      expect(tranferFeatureItem, findsOneWidget);
    });

    testWidgets('Should display the the transaction feed feature', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Dashboard(contactDao: mockContactDao)));
      final tranferFeatureItem = find.byWidgetPredicate(
        (widget) => dashBoadCardMatcher(widget: widget, title: 'Transactions', icon: Icons.description)
      );
      expect(tranferFeatureItem, findsOneWidget);
    });
  });
}