import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import '../web_client.dart';
import 'dart:convert';

class I18NWebClient {
  final String viewId;
  // TODO: add language variable

  I18NWebClient({@required this.viewId});

  Future<Map<String, dynamic>> getTranlations() async {
    final Response response = await client.get('$translationsUrl$viewId.json');
    final Map<String, dynamic> translations = jsonDecode(response.body);

    return translations;
  }
}
