import 'package:flutter/material.dart';
import 'package:flutter_local_db/main.dart';
import 'package:flutter_local_db/models/contact.dart';
import 'package:flutter_local_db/pages/contact_form.dart';
import 'package:flutter_local_db/pages/dashboard.dart';
import 'package:flutter_local_db/pages/transfer_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mocks.dart';
import 'events/events.dart';

void main() {
  MockContactDao mockContactDao;
  MockTransactionWebClient mockTransactionWebClient;

  setUp(() async {
    mockContactDao = MockContactDao();
    mockTransactionWebClient = MockTransactionWebClient();
  });

  testWidgets('Should save a contact', (tester) async {
    await tester.pumpWidget(ByteBankApp(contactDao: mockContactDao, transactionWebClient: mockTransactionWebClient));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    await tapOnTransferItem(tester);
    await tester.pumpAndSettle();

    final contactList = find.byType(TransferList);
    expect(contactList, findsOneWidget);

    verify(mockContactDao.getAll()).called(1);

    await tapOnAddContactFloatButton(tester);
    await tester.pumpAndSettle();

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);

    await fillTextFieldByLabelText(tester: tester, labelText: 'Full name', text: 'New name');

    await fillTextFieldByLabelText(tester: tester, labelText: 'Account number', text: '1000');

    await tapOnWidgetWithText(tester: tester, type: RaisedButton, text: 'Create');
    await tester.pumpAndSettle();

    verify(mockContactDao.insert(contact: Contact(0, 'New name', 1000)))
    .called(1);

    final updatedContactList = find.byType(TransferList);
    expect(updatedContactList, findsOneWidget);

    verify(mockContactDao.getAll()).called(1);
  });
}