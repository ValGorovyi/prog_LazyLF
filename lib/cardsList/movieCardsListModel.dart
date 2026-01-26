import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prog_lazy_f/domain/apiClient/apiClient.dart';
import 'package:prog_lazy_f/domain/entity/movie.dart' show MovieType;
import 'package:prog_lazy_f/navigation/mainNavigation.dart'
    show NavigationRoutesNames;

class movieCardsListModel extends ChangeNotifier {
  final _apiCl = ApiClient();
  final _movies = <MovieType>[];
  List<MovieType> get movies => List.unmodifiable(_movies);
  late DateFormat _dateFormat;
  String _locale = '';
  String stringFormatDate(DateTime? date) {
    if (date != null) return _dateFormat.format(date);
    return '';
  }

  void setupLocate(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMd(_locale);
    _movies.clear();
    loadMovies();
    // _locale = locale.toString();
    // print(_locale);
  }

  Future<void> loadMovies() async {
    final _moviesRes = await _apiCl.popularMovie(
      1,
      _locale,
      // 'en-US',
    ); // 'ru-RU' // 'en-US'
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
