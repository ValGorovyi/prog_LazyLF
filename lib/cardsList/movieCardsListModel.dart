import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prog_lazy_f/domain/apiClient/apiClient.dart';
import 'package:prog_lazy_f/domain/entity/movie.dart' show MovieType;
import 'package:prog_lazy_f/navigation/mainNavigation.dart'
    show NavigationRoutesNames;

class movieCardsListModel extends ChangeNotifier {
  final _apiCl = ApiClient();
  final _movies = <MovieType>[];
  List<MovieType> get movies => List.unmodifiable(_movies);

  Future<void> loadMovies() async {
    final _moviesRes = await _apiCl.popularMovie(1, 'en-US');
    _movies.addAll(_moviesRes.movies);
    notifyListeners();
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(
      context,
    ).pushNamed(NavigationRoutesNames.idRoute, arguments: id);
  }
}
