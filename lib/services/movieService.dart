import 'package:prog_lazy_f/configuration/configuration.dart'
    show Configuration;
import 'package:prog_lazy_f/domain/apiClient/accountApiClient.dart'
    show AccountApiClient, MediaType;
import 'package:prog_lazy_f/domain/apiClient/dataProvider.dart'
    show SessionDataProvider;
import 'package:prog_lazy_f/domain/apiClient/movieApiClient.dart'
    show MovieApiClient;
import 'package:prog_lazy_f/domain/entity/popularMoviesRes.dart';
import 'package:prog_lazy_f/domain/localEntity/movieDetailsLocal.dart'
    show MovieDetailsLocal;

class MovieService {
  final _movieApiCl = MovieApiClient();

  final _accountApiCl = AccountApiClient();
  final _sessionDataPr = SessionDataProvider();

  Future<popularMoviesResponceType> popularMovie(
    int page,
    String locale,
  ) async {
    return _movieApiCl.popularMovie(page, locale, Configuration.apiKey);
  }

  Future<popularMoviesResponceType> searchMovie(
    int page,
    String locale,
    String query,
  ) {
    return _movieApiCl.searchMovie(page, locale, query, Configuration.apiKey);
  }

  Future<MovieDetailsLocal> loadDetails({
    required String locale,
    required int movieId,
  }) async {
    final movieDetails = await _movieApiCl.movieDetails(movieId, locale);
    final sessionId = await _sessionDataPr.getSessionId();
    var isFavorire = false;
    if (sessionId != null) {
      isFavorire = await _movieApiCl.isFavorire(movieId, sessionId);
    }
    return MovieDetailsLocal(details: movieDetails, isFavorite: isFavorire);
  }

  Future<void> updateFavorite({
    required bool isFavorite,
    required int movieId,
  }) async {
    final sessionId = await _sessionDataPr.getSessionId();
    final accId = await _sessionDataPr.getAccountId();
    if (accId == null || sessionId == null) return;
    await _accountApiCl.markAsFavorite(
      accountId: accId,
      sessionId: sessionId,
      mediaType: MediaType.Movie,
      mediaId: movieId,
      favorite: isFavorite,
    );
  }
}
