import 'package:http_interceptor/http_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'package:http/http.dart';

final Client client = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
  requestTimeout: Duration(seconds: 5),
);
const String url = 'http://localhost:8081/transactions';
const String translationsUrl = 'https://gist.githubusercontent.com/MatheusMassula/24bc0b25cb049b18bdf39c4530841a8f/raw/a1f164a3f11541b90673f7ee458770a295d081b6/';