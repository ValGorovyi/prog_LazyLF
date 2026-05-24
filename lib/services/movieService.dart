import 'package:prog_lazy_f/configuration/configuration.dart'
    show Configuration;
import 'package:prog_lazy_f/domain/apiClient/movieApiClient.dart'
    show MovieApiClient;
import 'package:prog_lazy_f/domain/entity/popularMoviesRes.dart';

class MovieService {
  final _movieApiCl = MovieApiClient();

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
}

// 1/10
