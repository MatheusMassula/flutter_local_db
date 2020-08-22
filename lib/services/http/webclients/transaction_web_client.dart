import 'package:flutter_local_db/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../web_client.dart';
import 'dart:convert';

class TransactionWebClient {
  Future<List<Transaction>> getAllTransactions() async {
    final Response response = await client.get(url);
    final List<dynamic> jsonList = jsonDecode(response.body);

    return jsonList
      .map((transaction) => Transaction.fromJson(transaction))
      .toList();
  }

  Future<Transaction> sendTransaction({
    @required Transaction transaction,
    String password
  }) async {
    final Map<String, String> header = {
      'Content-Type': 'application/json',
      'password': password
    };

    final Response response = await client
      .post(url, headers: header, body: jsonEncode(transaction.toJson()));

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    print('response.statusCode: ${response.statusCode}');
    throw HttpException(_statusCodeResponse[response.statusCode]?? 'Unknown error');
  }

  static final Map<int, String> _statusCodeResponse = {
    400: 'There was an error submitting transaction',
    401: 'Unauthorized transaction',
    409: 'Tranference already exists'
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
