import 'package:flutter/material.dart';
import 'package:flutter_local_db/main.dart';
import 'package:flutter_local_db/models/contact.dart';
import 'package:flutter_local_db/pages/contact_form.dart';
import 'package:flutter_local_db/pages/dashboard.dart';
import 'package:flutter_local_db/pages/transfer_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'matchers.dart';
import 'mocks.dart';

void main() {
  testWidgets('Should save a contact', (tester) async {
    final mockContactDao = MockContactDao();
    await tester.pumpWidget(ByteBankApp(contactDao: mockContactDao));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final transferFeatureItem = find.byWidgetPredicate((widget) =>
        dashBoadCardMatcher(
            widget: widget, title: 'Transfer', icon: Icons.monetization_on));
    expect(transferFeatureItem, findsOneWidget);

    await tester.tap(transferFeatureItem);
    //As the tap action changes the UI (in this case), we should place an pump method to reload the window
    await tester.pumpAndSettle();

    final contactList = find.byType(TransferList);
    expect(contactList, findsOneWidget);

    verify(mockContactDao.getAll()).called(1);

    final addContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(addContact, findsOneWidget);
    await tester.tap(addContact);
    await tester.pumpAndSettle();

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);

    final nameTextFiel = find
        .byWidgetPredicate((widget) => textFieldMatcher(widget, 'Full name'));
    expect(nameTextFiel, findsOneWidget);

    await tester.enterText(nameTextFiel, 'New name');

    final accountNumberTextFiel = find.byWidgetPredicate(
        (widget) => textFieldMatcher(widget, 'Account number'));
    expect(accountNumberTextFiel, findsOneWidget);

    await tester.enterText(accountNumberTextFiel, '1000');

    final createButton = find.widgetWithText(RaisedButton, 'Create');
    expect(createButton, findsOneWidget);
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    verify(
      mockContactDao.insert(contact: Contact(
        0,
        'New name',
        1000
      ))
    ).called(1);

    final updatedContactList = find.byType(TransferList);
    expect(updatedContactList, findsOneWidget);

    verify(mockContactDao.getAll()).called(1);
  });
}
