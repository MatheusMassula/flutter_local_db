import 'package:flutter/material.dart';
import 'package:flutter_local_db/pages/dashboard.dart';
import 'package:flutter_local_db/pages/widgets/dashboard_card.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should display bytebank logo when dashboard is opened', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final Finder logoImage = find.byType(Image);
    expect(logoImage, findsOneWidget);
  });

  testWidgets('Should display the first feature when the Dashboard is opened', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final Finder dashBoardItem = find.byType(DashboardCard);
    expect(dashBoardItem, findsWidgets);
  });
}