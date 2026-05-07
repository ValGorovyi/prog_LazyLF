import 'package:prog_lazy_f/configuration/configuration.dart'
    show Configuration;
import 'package:prog_lazy_f/domain/apiClient/networkClient.dart'
    show NetworkClient;

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

enum MediaType { Movie, TV }

class AccountApiClient {
  final _networkClient = NetworkClient();

  Future<int> markAsFavorite({
    required int accountId,
    required String sessionId,
    required MediaType mediaType,
    required int mediaId,
    required bool favorite,
  }) async {
    /// kostil !
    int parser(dynamic json) {
      return 1;
    }

    final paramsBody = <String, dynamic>{
      'media_type': mediaType.asString(),
      'media_id': mediaId,
      'favorite': favorite,
    };
    final result = _networkClient.postUniversal(
      '/account/$accountId/favorite',
      parser,
      paramsBody,
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'session_id': sessionId,
      },
    );
    return result;
  }

  Future<int> getAccId(String sessionId) async {
    int parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = jsonMap['id'] as int;
      return result;
    }

    final result = _networkClient.getUniversal(
      '/account',
      parser,
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'session_id': sessionId,
      },
    );
    return result;
  }
}
