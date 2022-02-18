import 'package:http/http.dart';
import '../web_client.dart';
import 'dart:convert';

class I18NWebClient {
  Future<Map<String, dynamic>> getTranlations() async {
    final Response response = await client.get(translationsUrl);
    final Map<String, dynamic> translations = jsonDecode(response.body);

    return translations;
  }
}
