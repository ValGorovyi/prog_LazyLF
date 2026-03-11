import 'dart:convert';
import 'dart:io';

import 'package:prog_lazy_f/domain/entity/movieDetails.dart'
    show MovieDetailsType;
import 'package:prog_lazy_f/domain/entity/popularMoviesRes.dart'
    show popularMoviesResponceType;

enum ApiClientExeptionType { Network, Auth, Other }

enum MediaType { Movie, TV }

extension MediaTypeAsString on MediaType {
  String asString() {
    switch (this) {
      case MediaType.Movie:
        return 'movie';
      case MediaType.TV:
        return 'tv';
    }
  }
}

class ApiClientExeption implements Exception {
  final ApiClientExeptionType type;
  ApiClientExeption(this.type);
}

class ApiClient {
  final _client = HttpClient();
  static const _host = 'https://api.themoviedb.org/3';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = 'c0229fa065fb8b73cb55c1fae3cd1a18';
  static const _headerApiKey =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjMDIyOWZhMDY1ZmI4YjczY2I1NWMxZmFlM2NkMWExOCIsIm5iZiI6MTc2MzYzNzE5OS41Nzc5OTk4LCJzdWIiOiI2OTFlZjdjZjhmNWRlOTYzYmEyZTJiM2IiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.K3zT3xGgiDL0c4eApgdbFvzw10q_tYV9PfajiMnjVJ4';

  static String imageUrl(String pathSrc) {
    return _imageUrl + pathSrc;
  }

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
  }

  void _validateResponce(HttpClientResponse responce, dynamic json) {
    if (responce.statusCode == 401) {
      final dynamic statusCodeInt = json['status_code'];
      final code = statusCodeInt is int ? statusCodeInt : 0;
      if (code == 30) {
        throw ApiClientExeption(ApiClientExeptionType.Auth);
      } else {
        throw ApiClientExeption(ApiClientExeptionType.Other);
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
      // print(e);
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
      final request = await _client.postUrl(url);
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(bodyParams));
      final responce = await request.close();

      /// kostil !
      if (responce.statusCode == 201) {
        return 1 as T;
      }
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

  Future<int> getAccId(String sessionId) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = jsonMap['id'] as int;
      return result;
    };
    final result = _getUniversal('/account', parser, <String, dynamic>{
      'api_key': _apiKey,
      'session_id': sessionId,
    });
    return result;
  }

  Future<popularMoviesResponceType> popularMovie(
    int page,
    String language,
  ) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final responce = popularMoviesResponceType.fromJson(jsonMap);
      return responce;
    };
    final result = _getUniversal('/movie/popular', parser, <String, dynamic>{
      'api_key': _apiKey,
      'page': page.toString(),
      'language': language,
    });
    return result;
  }

  Future<bool> isFavorire(int movieId, String sessionId) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      print(jsonMap);
      final favoriteJson = jsonMap['favorite'] as bool;
      print(favoriteJson);
      return favoriteJson;
    };
    final result = _getUniversal(
      '/movie/$movieId/account_states',
      parser,
      <String, dynamic>{'session_id': sessionId, 'api_key': _apiKey},
    );
    return result;
  }

  Future<popularMoviesResponceType> searchMovie(
    int page,
    String language,
    String query,
  ) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final responce = popularMoviesResponceType.fromJson(jsonMap);
      return responce;
    };
    final result = _getUniversal('/search/movie', parser, <String, dynamic>{
      'api_key': _apiKey,
      'page': page.toString(),
      'language': language,
      'query': query,
      'include_adult': true.toString(),
    });
    return result;
  }

  Future<int> markAsFavorite({
    required int accountId,
    required String sessionId,
    required MediaType mediaType,
    required int mediaId,
    required bool favorite,
  }) async {
    /// kostil !
    final parser = (dynamic json) {
      return 1;
    };

    final paramsBody = <String, dynamic>{
      'media_type': mediaType.asString(),
      'media_id': mediaId.toString(),
      'favorite': favorite.toString(),
    };
    final result = _postUniversal(
      '/account/$accountId/favorite',
      parser,
      paramsBody,
      <String, dynamic>{'api_key': _apiKey, 'session_id': sessionId},
    );
    return result;
  }

  Future<MovieDetailsType> movieDetails(int movieId, String language) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final responce = MovieDetailsType.fromJson(jsonMap);
      return responce;
    };
    final result = _getUniversal('/movie/$movieId', parser, <String, dynamic>{
      'append_to_response': 'credits,videos',
      'api_key': _apiKey,
      'language': language,
    });
    return result;
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

//eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjMDIyOWZhMDY1ZmI4YjczY2I1NWMxZmFlM2NkMWExOCIsIm5iZiI6MTc2MzYzNzE5OS41Nzc5OTk4LCJzdWIiOiI2OTFlZjdjZjhmNWRlOTYzYmEyZTJiM2IiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.K3zT3xGgiDL0c4eApgdbFvzw10q_tYV9PfajiMnjVJ4



// dart run build_runner build