import 'package:flutter_local_db/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Should return the transaction value that was send',
    () {
      final transaction = Transaction(null, 200, null);
      expect(transaction.value, 200);
    }
  );

  test('Shouldn\'t receive values equal or lower than zero', () {
    expect(() => Transaction(null, 0, null), throwsAssertionError);
  });
}