import 'dart:convert';
import 'dart:io';

enum ApiClientExeptionType { Network, Auth, Other }

class ApiClientExeption implements Exception {
  final ApiClientExeptionType type;
  ApiClientExeption(this.type);
}

class ApiClient {
  final _client = HttpClient();
  static const _host = 'https://api.themoviedb.org/3';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = 'c0229fa065fb8b73cb55c1fae3cd1a18';

  Uri _createUri(String path, [Map<String, dynamic>? parameters]) {
    final myUri = Uri.parse('$_host$path');
    if (parameters != null) {
      return myUri.replace(queryParameters: parameters);
    } else {
      return myUri;
    }
  }

  Future<String> auth({
    required String username,
    required String password,
  }) async {
    final token = await _makeToken();
    final validToken = await _validateUser(
      userName: username,
      password: password,
      requestToken: token,
    );
    final sessionId = _makeSession(requestToken: validToken);
    return sessionId;
  }

  Future<String> _makeToken() async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = json['request_token'] as String;
      return token;
    };
    final result = _getUniversal(
      '/authentication/token/new',
      parser,
      <String, dynamic>{'api_key': _apiKey},
    );
    return result;
    // final url = _createUri('/authentication/token/new', <String, dynamic>{
    //   'api_key': _apiKey,
    // });
    // try {
    //   // final request = await _client.getUrl(url);
    //   // final responce = await request.close();
    //   // final json = (await responce.jsonDecode()) as Map<String, dynamic>;

    //   _validateResponce(responce, json);

    //   // final token = json['request_token'] as String;
    //   return token;
    // } on SocketException {
    //   throw ApiClientExeption(ApiClientExeptionType.Network);
    // } on ApiClientExeption {
    //   rethrow;
    // } catch (e) {
    //   throw ApiClientExeption(ApiClientExeptionType.Other);
    // }
  }

  Future<String> _validateUser({
    required String userName,
    required String password,
    required String requestToken,
  }) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = json['request_token'] as String;
      return token;
    };
    final result = _postUniversal(
      '/authentication/token/validate_with_login',
      parser,
      <String, dynamic>{
        'username': userName,
        'password': password,
        'request_token': requestToken,
      },
      <String, dynamic>{'api_key': _apiKey},
    );
    return result;
    // try {
    //   final url = _createUri(
    //     '/authentication/token/validate_with_login',
    //     <String, dynamic>{'api_key': _apiKey},
    //   );
    //   final params = <String, dynamic>{
    //     'username': userName,
    //     'password': password,
    //     'request_token': requestToken,
    //   };
    //   final request = await _client.postUrl(url);
    //   request.headers.contentType = ContentType.json;
    //   request.write(jsonEncode(params));
    //   final responce = await request.close();

    //   final json = (await responce.jsonDecode()) as Map<String, dynamic>;
    //   _validateResponce(responce, json);
    //   final token = json['request_token'] as String;
    //   return token;
    // } on SocketException {
    //   throw ApiClientExeption(ApiClientExeptionType.Network);
    // } on ApiClientExeption {
    //   rethrow;
    // } catch (e) {
    //   throw ApiClientExeption(ApiClientExeptionType.Other);
    // }
    // final url = _createUri(
    //   '/authentication/token/validate_with_login',
    //   <String, dynamic>{'api_key': _apiKey},
    // );
    // final params = <String, dynamic>{
    //   'username': userName,
    //   'password': password,
    //   'request_token': requestToken,
    // };
    // final request = await _client.postUrl(url);
    // request.headers.contentType = ContentType.json;
    // request.write(jsonEncode(params));
    // final responce = await request.close();
    // final json = (await responce.jsonDecode()) as Map<String, dynamic>;
    // final token = json['request_token'] as String;
    // return token;
  }

  Future<String> _makeSession({required String requestToken}) async {
    // final url = Uri.parse('$_host?api_key=$_apiKey');
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final sessionId = jsonMap['session_id'] as String;
      return sessionId;
    };
    final result = _postUniversal(
      '/authentication/session/new',
      parser,
      <String, dynamic>{'request_token': requestToken},
      <String, dynamic>{'api_key': _apiKey},
    );
    return result;

    // try {
    //   final url = _createUri('/authentication/session/new', <String, dynamic>{
    //     'api_key': _apiKey,
    //   });
    //   final params = <String, dynamic>{'request_token': requestToken};
    //   final request = await _client.postUrl(url);
    //   request.headers.contentType = ContentType.json;
    //   request.write(jsonEncode(params));
    //   final responce = await request.close();
    //   final json = (await responce.jsonDecode()) as Map<String, dynamic>;
    //   _validateResponce(responce, json);
    //   final sessionId = json['session_id'] as String;
    //   return sessionId;
    // } on SocketException {
    //   throw ApiClientExeption(ApiClientExeptionType.Network);
    // } on ApiClientExeption {
    //   rethrow;
    // } catch (e) {
    //   throw ApiClientExeption(ApiClientExeptionType.Other);
    // }

    // final url = _createUri('/authentication/session/new', <String, dynamic>{
    //   'api_key': _apiKey,
    // });
    // final params = <String, dynamic>{'request_token': requestToken};
    // final request = await _client.postUrl(url);
    // request.headers.contentType = ContentType.json;
    // request.write(jsonEncode(params));
    // final responce = await request.close();
    // final json = (await responce.jsonDecode()) as Map<String, dynamic>;
    // final sessionId = json['session_id'] as String;
    // return sessionId;
  }

  void _validateResponce(HttpClientResponse responce, dynamic json) {
    if (responce.statusCode == 401) {
      final dynamic statusCodeInt = json['status_code'];
      final code = statusCodeInt is int ? statusCodeInt : 0;
      if (code == 30) {
        throw ApiClientExeption(ApiClientExeptionType.Auth);
      } else {
        ApiClientExeption(ApiClientExeptionType.Other);
      }
    }
  }

  Future<T> _getUniversal<T>(
    String path,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? parameters,
  ]) async {
    final url = _createUri(path, parameters);
    try {
      final request = await _client.getUrl(url);
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

  Future<T> _postUniversal<T>(
    String path,
    T Function(dynamic json) parser,
    Map<String, dynamic> bodyParams, [
    Map<String, dynamic>? urlParams,
  ]) async {
    try {
      final url = _createUri(path, urlParams);
      // final params = <String, dynamic>{
      //   'username': userName,
      //   'password': password,
      //   'request_token': requestToken,
      // };
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
}

extension HttpClientResJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(
      utf8.decoder,
    ).toList().then((value) => value.join()).then((v) => json.decode(v));
  }
}

// val_done_dart
// Val228
// c0229fa065fb8b73cb55c1fae3cd1a18
// TMDB
// 35


 /*
 statusCode 30 - err login pasw
7 - err api key
33 - err api token
 */