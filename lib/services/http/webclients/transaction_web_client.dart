import 'package:flutter_local_db/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../web_client.dart';
import 'dart:convert';

class TransactionWebClient {
  Future<List<Transaction>> getAllTransactions() async {
    final Response response = await client.get(url).timeout(Duration(seconds: 15));
    final List<Transaction> transactionList = List();

    for (var transaction in jsonDecode(response.body)) {
      transactionList.add(Transaction.fromJson(transaction));
    }

    return transactionList;
  }

  Future<Transaction> sendTransaction({@required Transaction transaction}) async {
    final Map<String, String> header = {
      'Content-Type': 'application/json',
      'password': '1000'
    };

    final Response response = await client.post(
      url,
      headers: header,
      body: jsonEncode(transaction.toJson())
    ).timeout(Duration(seconds: 15));

    return Transaction.fromJson(jsonDecode(response.body));
  }
}