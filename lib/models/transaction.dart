import 'package:flutter_local_db/models/contact.dart';

class Transaction {
  final double value;
  final Contact contact;

  Transaction(
    this.value,
    this.contact,
  );

  Transaction.fromJson(Map<String, dynamic> json)
    : value = json['value'],
    contact = json['contact'];

  Map<String, dynamic> toJson() => {
    'value': value,
    'contact': contact.toJson()
  };
}