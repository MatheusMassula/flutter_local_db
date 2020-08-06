import 'package:http_interceptor/http_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'package:http/http.dart';

final Client client = HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
const String url = 'http://localhost:8081/transactions';