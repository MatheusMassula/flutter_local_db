import 'package:flutter/material.dart';
import 'package:flutter_local_db/main.dart';
import 'package:flutter_local_db/models/contact.dart';
import 'package:flutter_local_db/pages/contact_form.dart';
import 'package:flutter_local_db/pages/dashboard.dart';
import 'package:flutter_local_db/pages/transfer_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';
import 'events/events.dart';

void main() {
  MockContactDao mockContactDao;

  setUp(() async {
    mockContactDao = MockContactDao();
  });

  testWidgets('Should save a contact', (tester) async {
    await tester.pumpWidget(ByteBankApp(contactDao: mockContactDao));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    await tapOnTransferItem(tester);
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
        .byWidgetPredicate((widget) => textFieldByLabelTextMatcher(widget: widget, labelText: 'Full name'));
    expect(nameTextFiel, findsOneWidget);

    await tester.enterText(nameTextFiel, 'New name');

    final accountNumberTextFiel = find.byWidgetPredicate(
        (widget) => textFieldByLabelTextMatcher(widget: widget, labelText: 'Account number'));
    expect(accountNumberTextFiel, findsOneWidget);

    await tester.enterText(accountNumberTextFiel, '1000');

    final createButton = find.widgetWithText(RaisedButton, 'Create');
    expect(createButton, findsOneWidget);
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    verify(mockContactDao.insert(contact: Contact(0, 'New name', 1000)))
    .called(1);

    final updatedContactList = find.byType(TransferList);
    expect(updatedContactList, findsOneWidget);

    verify(mockContactDao.getAll()).called(1);
  });
}
