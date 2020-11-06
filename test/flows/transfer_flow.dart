import 'package:flutter/material.dart';
import 'package:flutter_local_db/main.dart';
import 'package:flutter_local_db/pages/dashboard.dart';
import 'package:flutter_local_db/pages/transfer_list.dart';
import 'package:flutter_local_db/pages/widgets/contact_tile.dart';
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

    await tapOnTransferItem(tester);
    await tester.pumpAndSettle();

    final contactList = find.byType(TransferList);
    expect(contactList, findsOneWidget);

    verify(mockContactDao.getAll()).called(1);

    final contact = find.byType(ContactTile);
    expect(contact, findsWidgets);
    await tester.tap(contact.first);
    tester.pumpAndSettle();
  });
}