import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class HttpClient {
  final String baseUrl;
  Map<String, String> headers;
  final List<http.BaseRequest>? interceptors;

  HttpClient(this.baseUrl, this.headers, {this.interceptors});

  Future<dynamic> get(String uri, Map<String, String> headers) async {
    try {
      final url = Uri.parse('$baseUrl$uri');
      final response = await http.get(url, headers: headers);
      final decodedResponse = _decodeResponse(response);
      return decodedResponse;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final url = Uri.parse('$baseUrl$uri');
      final response = await http.post(url,
          headers: headers,
          body: jsonEncode(data),
          encoding: Encoding.getByName('utf-8'));
      final decodedResponse = _decodeResponse(response);
      return decodedResponse;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  dynamic _decodeResponse(http.Response response) {
    final body = response.body;
    final contentType = response.headers['content-type'];
    if (contentType?.contains('application/json') == true) {
      return jsonDecode(body);
    } else {
      return body;
    }
  }
}
