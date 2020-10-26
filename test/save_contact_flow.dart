import 'package:flutter/material.dart';
import 'package:flutter_local_db/main.dart';
import 'package:flutter_local_db/pages/contact_form.dart';
import 'package:flutter_local_db/pages/dashboard.dart';
import 'package:flutter_local_db/pages/transfer_list.dart';
import 'package:flutter_test/flutter_test.dart';

import 'matchers.dart';

void main() {
  testWidgets('Should save a contact', (tester) async {
    await tester.pumpWidget(ByteBankApp());

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final transferFeatureItem = find.byWidgetPredicate((widget) => dashBoadCardMatcher(
      widget: widget,
      title: 'Transfer',
      icon: Icons.monetization_on
    ));
    expect(transferFeatureItem, findsOneWidget);

    await tester.tap(transferFeatureItem);
    //As the tap action changes the UI (in this case), we should place an pump method to reload the window
    await tester.pumpAndSettle();

    final contactList = find.byType(TransferList);
    expect(contactList, findsOneWidget);

    final addContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(addContact, findsNothing);
    await tester.tap(addContact);
    await tester.pumpAndSettle();

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);
  });
}