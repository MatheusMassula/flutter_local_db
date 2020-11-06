import 'package:flutter/material.dart';
import 'package:flutter_local_db/main.dart';
import 'package:flutter_local_db/models/contact.dart';
import 'package:flutter_local_db/pages/dashboard.dart';
import 'package:flutter_local_db/pages/transaction_form.dart';
import 'package:flutter_local_db/pages/transfer_list.dart';
import 'package:flutter_local_db/pages/widgets/contact_tile.dart';
import 'package:flutter_local_db/pages/widgets/transaction_auth_dialog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';
import 'events/events.dart';

void main() {
  testWidgets('Tranfer to a contact', (tester) async {
    final mockContactDao = MockContactDao();
    await tester.pumpWidget(ByteBankApp(contactDao: mockContactDao));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    when(mockContactDao.getAll())
      .thenAnswer((invocation) async {
        return [Contact(0, 'Full name', 1000)];
      });
    
    await tapOnTransferItem(tester);
    await tester.pumpAndSettle();

    final contactList = find.byType(TransferList);
    expect(contactList, findsOneWidget);

    verify(mockContactDao.getAll()).called(1);

    final contact = find.byWidgetPredicate((widget) {
      if(widget is ContactTile) {
        return widget.contact.name == 'Full name'
        && widget.contact.accountNumber == 1000;
      }
      return false;
    });
    expect(contact, findsWidgets);

    await tester.tap(contact.first);
    await tester.pumpAndSettle();

    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm, findsOneWidget);

    final valueField = find.byWidgetPredicate((widget) => textFieldMatcher(widget: widget, labelText: 'Value'));
    expect(valueField, findsOneWidget);
    await tester.enterText(valueField, '100');

    final transferButton = find.widgetWithText(RaisedButton, 'Transfer');
    await tester.tap(transferButton);
    await tester.pumpAndSettle();

    final authDialog = find.byType(TransactionAuthDialog);
    expect(authDialog, findsOneWidget);
    
    final passcodeField = find.byWidgetPredicate((widget) {
      if(widget is TextField) {
        return widget.obscureText && widget.maxLength == 4;
      }
      return false;
    });
    expect(passcodeField, findsOneWidget);
    await tester.enterText(passcodeField, '1000');

    final acceptButton = find.widgetWithText(FlatButton, 'Accept');
    expect(acceptButton, findsOneWidget);
  });
}