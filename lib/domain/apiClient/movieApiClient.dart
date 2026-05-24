import 'package:prog_lazy_f/configuration/configuration.dart'
    show Configuration;
import 'package:prog_lazy_f/domain/apiClient/apiClientExeption.dart'
    show ApiClientExeptionType;
import 'package:prog_lazy_f/domain/apiClient/networkClient.dart'
    show NetworkClient;
import 'package:prog_lazy_f/domain/entity/movieDetails.dart'
    show MovieDetailsType;
import 'package:prog_lazy_f/domain/entity/popularMoviesRes.dart'
    show popularMoviesResponceType;

class ApiClientExeption implements Exception {
  final ApiClientExeptionType type;
  ApiClientExeption(this.type);
}

class MovieApiClient {
  final _networkClient = NetworkClient();

  // static const _host = 'https://api.themoviedb.org/3';
  // static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  // static const _apiKey = 'c0229fa065fb8b73cb55c1fae3cd1a18';
  // static const _headerApiKey =
  //     'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjMDIyOWZhMDY1ZmI4YjczY2I1NWMxZmFlM2NkMWExOCIsIm5iZiI6MTc2MzYzNzE5OS41Nzc5OTk4LCJzdWIiOiI2OTFlZjdjZjhmNWRlOTYzYmEyZTJiM2IiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.K3zT3xGgiDL0c4eApgdbFvzw10q_tYV9PfajiMnjVJ4';

  // static String imageUrl(String pathSrc) {
  //   return _imageUrl + pathSrc;
  // }

  // Uri _createUri(String path, [Map<String, dynamic>? parameters]) {
  //   final myUri = Uri.parse('$_host$path');
  //   if (parameters != null) {
  //     return myUri.replace(queryParameters: parameters);
  //   } else {
  //     return myUri;
  //   }
  // }

  // void _validateResponce(HttpClientResponse responce, dynamic json) {
  //   if (responce.statusCode == 401) {
  //     final dynamic statusCodeInt = json['status_code'];
  //     final code = statusCodeInt is int ? statusCodeInt : 0;
  //     if (code == 30) {
  //       throw ApiClientExeption(ApiClientExeptionType.Auth);
  //     } else if (code == 3) {
  //       throw ApiClientExeption(ApiClientExeptionType.SessionExpired);
  //     } else {
  //       throw ApiClientExeption(ApiClientExeptionType.Other);
  //     }
  //   }
  // }

  // Future<T> _getUniversal<T>(
  //   String path,
  //   T Function(dynamic json) parser, [
  //   Map<String, dynamic>? parameters,
  // ]) async {
  //   final url = _createUri(path, parameters);
  //   try {
  //     final request = await _client.getUrl(url);
  //     final responce = await request.close();
  //     final dynamic json = (await responce.jsonDecode());

  //     _validateResponce(responce, json);
  //     final result = parser(json);
  //     return result;
  //   } on SocketException {
  //     throw ApiClientExeption(ApiClientExeptionType.Network);
  //   } on ApiClientExeption {
  //     rethrow;
  //   } catch (e) {
  //     throw ApiClientExeption(ApiClientExeptionType.Other);
  //   }
  // }

  // Future<T> _postUniversal<T>(
  //   String path,
  //   T Function(dynamic json) parser,
  //   Map<String, dynamic> bodyParams, [
  //   Map<String, dynamic>? urlParams,
  // ]) async {
  //   try {
  //     final url = _createUri(path, urlParams);
  //     final request = await _client.postUrl(url);
  //     request.headers.contentType = ContentType.json;
  //     request.write(jsonEncode(bodyParams));
  //     final responce = await request.close();
  //     final dynamic json = (await responce.jsonDecode());
  //     _validateResponce(responce, json);
  //     final result = parser(json);
  //     return result;
  //   } on SocketException {
  //     throw ApiClientExeption(ApiClientExeptionType.Network);
  //   } on ApiClientExeption {
  //     rethrow;
  //   } catch (e) {
  //     throw ApiClientExeption(ApiClientExeptionType.Other);
  //   }
  // }

  Future<popularMoviesResponceType> popularMovie(
    int page,
    String language,
    String apiKey,
  ) async {
    popularMoviesResponceType parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final responce = popularMoviesResponceType.fromJson(jsonMap);
      return responce;
    }

    final result = _networkClient.getUniversal(
      '/movie/popular',
      parser,
      <String, dynamic>{
        'api_key': apiKey,
        'page': page.toString(),
        'language': language,
      },
    );
    return result;
  }

  Future<bool> isFavorire(int movieId, String sessionId) async {
    bool parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final favoriteJson = jsonMap['favorite'] as bool;
      return favoriteJson;
    }

    final result = _networkClient.getUniversal(
      '/movie/$movieId/account_states',
      parser,
      <String, dynamic>{
        'session_id': sessionId,
        'api_key': Configuration.apiKey,
      },
    );
    return result;
  }

  Future<popularMoviesResponceType> searchMovie(
    int page,
    String language,
    String query,
    String apiKey,
  ) async {
    popularMoviesResponceType parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final responce = popularMoviesResponceType.fromJson(jsonMap);
      return responce;
    }

    final result = _networkClient
        .getUniversal('/search/movie', parser, <String, dynamic>{
          'api_key': apiKey,
          'page': page.toString(),
          'language': language,
          'query': query,
          'include_adult': true.toString(),
        });
    return result;
  }

  Future<MovieDetailsType> movieDetails(int movieId, String language) async {
    MovieDetailsType parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final responce = MovieDetailsType.fromJson(jsonMap);
      return responce;
    }

    final result = _networkClient
        .getUniversal('/movie/$movieId', parser, <String, dynamic>{
          'append_to_response': 'credits,videos',
          'api_key': Configuration.apiKey,
          'language': language,
        });
    return result;
  }
}

// extension HttpClientResJsonDecode on HttpClientResponse {
//   Future<dynamic> jsonDecode() async {
//     return transform(
//       utf8.decoder,
//     ).toList().then((value) => value.join()).then((v) => json.decode(v));
//   }
// }

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