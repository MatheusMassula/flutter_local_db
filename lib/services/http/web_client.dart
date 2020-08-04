import 'package:flutter_local_db/models/transaction.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart';
import 'dart:convert';

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
  final Client client = HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
  final Response response = await client.get('http://localhost:8081/transactions');
  final List<Transaction> transactionList = List();

  for (var transaction in jsonDecode(response.body)) {
    transactionList.add(Transaction.fromJson(transaction));
  }

  return transactionList;
}