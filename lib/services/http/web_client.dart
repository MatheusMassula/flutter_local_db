import 'package:flutter/material.dart';
import 'package:flutter_local_db/models/transaction.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart';
import 'dart:convert';

final Client client = HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
final String url = 'http://localhost:8081/transactions';

class LoggingInterceptor implements InterceptorContract {

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print('Request baseUrl: ${data.baseUrl}');
    print('Request headers: ${data.headers}');
    print('Request body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
      print('Response statusCode: ${data.statusCode}');
      print('Response headers: ${data.headers}');
      print('Response body: ${data.body}');
      return data;
  }

}

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

  print('transaction as json: ${transaction.toJson()}');

  final Response response = await client.post(
    url,
    headers: header,
    body: jsonEncode(transaction.toJson())
  ).timeout(Duration(seconds: 15));

  return Transaction.fromJson(jsonDecode(response.body));
}