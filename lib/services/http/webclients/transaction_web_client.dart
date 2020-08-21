import 'package:flutter_local_db/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../web_client.dart';
import 'dart:convert';

class TransactionWebClient {
  Future<List<Transaction>> getAllTransactions() async {
    final Response response = await client.get(url).timeout(Duration(seconds: 15));
    final List<dynamic> jsonList = jsonDecode(response.body);

    return jsonList
      .map((transaction) => Transaction.fromJson(transaction))
      .toList();
  }

  Future<Transaction> sendTransaction({@required Transaction transaction, String password}) async {
    final Map<String, String> header = {
      'Content-Type': 'application/json',
      'password': password
    };

    final Response response = await client.post(
      url,
      headers: header,
      body: jsonEncode(transaction.toJson())
    ).timeout(Duration(seconds: 15));

    switch (response.statusCode) {
      case 400:
        throw Exception('There was an error submitting transaction');
        break;
      case 401:
      throw Exception('Unauthorized transaction');
        break;
    }

    return Transaction.fromJson(jsonDecode(response.body));
  }
}