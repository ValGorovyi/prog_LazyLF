import 'dart:convert';
import 'dart:io';

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
    // final url = Uri.parse('$_host/?api_key=$_apiKey');
    final url = _createUri('/authentication/token/new', <String, dynamic>{
      'api_key': _apiKey,
    });
    final request = await _client.getUrl(url);
    print(request);
    final responce = await request.close();
    print(responce);
    final json = (await responce.jsonDecode()) as Map<String, dynamic>;
    final token = json['request_token'] as String;
    return token;
  }

  Future<String> _validateUser({
    required String userName,
    required String password,
    required String requestToken,
  }) async {
    // final url = Uri.parse(
    //   '$_host?api_key=$_apiKey',
    // );
    final url = _createUri(
      '/authentication/token/validate_with_login',
      <String, dynamic>{'api_key': _apiKey},
    );
    final params = <String, dynamic>{
      'username': userName,
      'password': password,
      'request_token': requestToken,
    };
    final request = await _client.postUrl(url);
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(params));
    final responce = await request.close();
    final json = (await responce.jsonDecode()) as Map<String, dynamic>;
    final token = json['request_token'] as String;
    return token;
  }

  Future<String> _makeSession({required String requestToken}) async {
    // final url = Uri.parse('$_host?api_key=$_apiKey');
    final url = _createUri('/authentication/session/new', <String, dynamic>{
      'api_key': _apiKey,
    });
    final params = <String, dynamic>{'request_token': requestToken};
    final request = await _client.postUrl(url);
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(params));
    final responce = await request.close();
    final json = (await responce.jsonDecode()) as Map<String, dynamic>;
    final sessionId = json['session_id'] as String;
    return sessionId;
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
