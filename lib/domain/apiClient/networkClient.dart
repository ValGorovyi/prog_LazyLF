import 'dart:io';
import 'dart:convert';
import 'package:prog_lazy_f/configuration/configuration.dart';
import 'package:prog_lazy_f/domain/apiClient/apiClientExeption.dart';
// 14

class NetworkClient {
  final _client = HttpClient();

  Uri _createUri(String path, [Map<String, dynamic>? parameters]) {
    final myUri = Uri.parse('${Configuration.host}$path');
    if (parameters != null) {
      return myUri.replace(queryParameters: parameters);
    } else {
      return myUri;
    }
  }

  Future<T> getUniversal<T>(
    String path,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? parameters,
  ]) async {
    final url = _createUri(path, parameters);
    try {
      final request = await _client.getUrl(url);
      final responce = await request.close();
      final dynamic json = (await responce.jsonDecode()); //??

      _validateResponce(responce, json);
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientExeption(ApiClientExeptionType.Network);
    } on ApiClientExeption {
      rethrow;
    } catch (e) {
      throw ApiClientExeption(ApiClientExeptionType.Other);
    }
  }

  Future<T> postUniversal<T>(
    String path,
    T Function(dynamic json) parser,
    Map<String, dynamic> bodyParams, [
    Map<String, dynamic>? urlParams,
  ]) async {
    try {
      final url = _createUri(path, urlParams);
      final request = await _client.postUrl(url);
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(bodyParams));
      final responce = await request.close();
      final dynamic json = (await responce.jsonDecode());
      _validateResponce(responce, json);
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientExeption(ApiClientExeptionType.Network);
    } on ApiClientExeption {
      rethrow;
    } catch (e) {
      throw ApiClientExeption(ApiClientExeptionType.Other);
    }
  }

  void _validateResponce(HttpClientResponse responce, dynamic json) {
    if (responce.statusCode == 401) {
      final dynamic statusCodeInt = json['status_code'];
      final code = statusCodeInt is int ? statusCodeInt : 0;
      if (code == 30) {
        throw ApiClientExeption(ApiClientExeptionType.Auth);
      } else if (code == 3) {
        throw ApiClientExeption(ApiClientExeptionType.SessionExpired);
      } else {
        throw ApiClientExeption(ApiClientExeptionType.Other);
      }
    }
  }
}

extension HttpClientResJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(
      utf8.decoder,
    ).toList().then((value) => value.join()).then((v) => json.decode(v));
  }
}
