import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:server_driven_ui/type/json.type.dart';

class RequestTemplate {
  Map<String, String> headers = {};
  String method;
  String url = '';
  Object? body;
  Encoding? encoding;

  RequestTemplate(
    this.url, {
    this.method = '',
    this.body,
    this.encoding,
  });
}

class ResponseTemplate {
  RequestTemplate request;
  Map<String, String> headers;
  String body;
  int statusCode = 200;

  ResponseTemplate({
    required this.request,
    required this.headers,
    this.body = '',
    this.statusCode = 200,
  });
}

class HTTPAdapter {
  static Future<String> post(
    String url, {
    JSON data = const {},
  }) async {
    RequestTemplate request = RequestTemplate(url, method: 'POST', body: data);
    request.headers['Content-Type'] = 'application/json; charset=utf-8';
    request.headers['Accept'] = 'application/json; charset=utf-8';
    request.body =
        request.body is JSON? ? jsonEncode(request.body) : request.body;

    http.Response response = await http
        .post(
          Uri.parse(request.url),
          body: request.body,
          headers: request.headers,
        )
        .timeout(const Duration(seconds: 60));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw http.ClientException(
        response.statusCode.toString(),
        Uri.parse(request.url),
      );
    }
  }
}
