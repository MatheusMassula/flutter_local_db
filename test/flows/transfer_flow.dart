import 'package:flutter/material.dart';
import 'package:flutter_local_db/main.dart';
import 'package:flutter_local_db/models/contact.dart';
import 'package:flutter_local_db/models/transaction.dart';
import 'package:flutter_local_db/pages/dashboard.dart';
import 'package:flutter_local_db/pages/transaction_form.dart';
import 'package:flutter_local_db/pages/transfer_list.dart';
import 'package:flutter_local_db/pages/widgets/contact_tile.dart';
import 'package:flutter_local_db/pages/widgets/response_dialog.dart';
import 'package:flutter_local_db/pages/widgets/transaction_auth_dialog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';
import 'events/events.dart';

void main() {
  MockContactDao mockContactDao;
  MockTransactionWebClient mockTransactionWebClient;

  setUp(() async {
    mockContactDao = MockContactDao();
    mockTransactionWebClient = MockTransactionWebClient();
  });

  testWidgets('Tranfer to a contact', (tester) async {
    await tester.pumpWidget(ByteBankApp(
      contactDao: mockContactDao,
      transactionWebClient: mockTransactionWebClient));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final contactMock = Contact(0, 'Full name', 1000);
    when(mockContactDao.getAll())
      .thenAnswer((invocation) async => [contactMock]);

    await tapOnTransferItem(tester);
    await tester.pumpAndSettle();

    final contactList = find.byType(TransferList);
    expect(contactList, findsOneWidget);

    verify(mockContactDao.getAll()).called(1);

    final contact = find.byWidgetPredicate((widget) {
      if (widget is ContactTile) {
        return widget.contact.name == 'Full name' &&
          widget.contact.accountNumber == 1000;
      }
      return false;
    });
    expect(contact, findsWidgets);

    await tester.tap(contact.first);
    await tester.pumpAndSettle();

    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm, findsOneWidget);

    final valueField = find.byWidgetPredicate((widget) =>
      textFieldByLabelTextMatcher(widget: widget, labelText: 'Value'));
    expect(valueField, findsOneWidget);
    await tester.enterText(valueField, '100');

    final transferButton = find.widgetWithText(RaisedButton, 'Transfer');
    await tester.tap(transferButton);
    await tester.pumpAndSettle();

    final authDialog = find.byType(TransactionAuthDialog);
    expect(authDialog, findsOneWidget);

    final passcodeField = find.byKey(transactionAuthDialogPasswordTextFieldKey);
    expect(passcodeField, findsOneWidget);
    await tester.enterText(passcodeField, '1000');

    final calcelButton = find.widgetWithText(FlatButton, 'Cancel');
    expect(calcelButton, findsOneWidget);

    final acceptButton = find.widgetWithText(FlatButton, 'Accept');
    expect(acceptButton, findsOneWidget);

    when(mockTransactionWebClient.sendTransaction(
      transaction: Transaction(null, 100, contactMock),
      password: '1000'
    ))
    .thenAnswer((_) async => Transaction(null, 100, contactMock));

    await tester.tap(acceptButton);
    await tester.pumpAndSettle();

    final successDialog = find.byType(SuccessDialog);
    expect(successDialog, findsOneWidget);

    final successConfirmButton = find.widgetWithText(FlatButton, 'Ok');
    expect(successConfirmButton, findsOneWidget);
    await tester.tap(successConfirmButton);
    await tester.pumpAndSettle();

    final contactListBack = find.byType(TransferList);
    expect(contactListBack, findsOneWidget);
  });
}
