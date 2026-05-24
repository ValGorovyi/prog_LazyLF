import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:prog_lazy_f/domain/apiClient/movieApiClient.dart';
import 'package:prog_lazy_f/domain/entity/movie.dart' show MovieType;
// import 'package:prog_lazy_f/domain/entity/popularMoviesRes.dart';
import 'package:prog_lazy_f/library/paginator.dart';
import 'package:prog_lazy_f/navigation/mainNavigation.dart'
    show NavigationRoutesNames;
import 'package:prog_lazy_f/services/movieService.dart' show MovieService;

class MovieListItemRowData {
  final String title;
  final String overview;
  final String releaseDate;
  final String? posterPath;
  final int id;

  MovieListItemRowData({
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.posterPath,
    required this.id,
  });
}

class MovieCardsListModel extends ChangeNotifier {
  final _movieService = MovieService();
  late final Paginator<MovieType> _popularMoviePaginator;
  late final Paginator<MovieType> _searchMoviePaginator;
  // final _apiCl = MovieApiClient();
  Timer? searchDebounce;
  String _locale = '';

  var _movies = <MovieListItemRowData>[];
  List<MovieListItemRowData> get movies => List.unmodifiable(_movies);
  late DateFormat _dateFormat;
  // late int _currentPage;
  // late int _totalPage;
  // var _isLoadingInProgress = false;
  String? _searchQueryText;
  bool get isSearchMode {
    final searchQ = _searchQueryText;
    return searchQ != null && searchQ.isNotEmpty;
  }

  MovieCardsListModel() {
    _popularMoviePaginator = Paginator<MovieType>((pageNumber) async {
      final resultOfResp = await _movieService.popularMovie(
        pageNumber,
        _locale,
      );
      return PaginatorLoadResult(
        data: resultOfResp.movies,
        currentPage: resultOfResp.page,
        totalPage: resultOfResp.totalPages,
      );
    });
    _searchMoviePaginator = Paginator<MovieType>((pageNumber) async {
      final resultOfResp = await _movieService.searchMovie(
        pageNumber,
        _locale,
        _searchQueryText ?? '',
      );
      return PaginatorLoadResult(
        data: resultOfResp.movies,
        currentPage: resultOfResp.page,
        totalPage: resultOfResp.totalPages,
      );
    });
  }

  // String stringFormatDate(DateTime? date) {
  //   if (date != null) return _dateFormat.format(date);
  //   return '';
  // }

  Future<void> setupLocate(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMd(_locale);
    await _resetList();
  }

  Future<void> _loadMoviesFromPage() async {
    if (isSearchMode) {
      await _searchMoviePaginator.loadMoviesFromPage();
      _movies = _searchMoviePaginator.data
          .map(_makeMovieListItemRowData)
          .toList();
    } else {
      await _popularMoviePaginator.loadMoviesFromPage();
      _movies = _popularMoviePaginator.data
          .map(_makeMovieListItemRowData)
          .toList();
    }
    notifyListeners();
    // if (_isLoadingInProgress || _currentPage >= _totalPage) return;
    // _isLoadingInProgress = true;
    // final nextPage = _currentPage + 1;

    // try {
    //   final _moviesRes = await _loadMovieFromQuery(
    //     nextPage,
    //     _locale,
    //   ); // 'ru-RU' // 'en-US'
    //   _movies.addAll(_moviesRes.movies.map(_makeMovieListItemRowData).toList());
    //   _currentPage = _moviesRes.page;
    //   _totalPage = _moviesRes.totalPages;
    //   _isLoadingInProgress = false;
    //   notifyListeners();
    // } catch (e) {
    //   //
    //   _isLoadingInProgress = false;
  }

  MovieListItemRowData _makeMovieListItemRowData(MovieType movieGlobalData) {
    final releaseDate = movieGlobalData.releaseDate;
    final releaseDateTitle = releaseDate != null
        ? _dateFormat.format(releaseDate)
        : '';
    return MovieListItemRowData(
      id: movieGlobalData.id,
      title: movieGlobalData.title,
      overview: movieGlobalData.overview,
      releaseDate: releaseDateTitle,
      posterPath: movieGlobalData.posterPath,
    );
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(
      context,
    ).pushNamed(NavigationRoutesNames.idRoute, arguments: id);
  }

  void showMovieAtIndex(int index) async {
    if (index < _movies.length - 2) return;

    _loadMoviesFromPage();
  }

  // Future<popularMoviesResponceType> _loadMovieFromQuery(
  //   int page,
  //   String locale,
  // ) async {
  //   final query = _searchQueryText;
  //   if (query == null) {
  //     return await _apiCl.popularMovie(page, locale);
  //   } else {
  //     return await _apiCl.searchMovie(page, locale, query);
  //   }
  // }

  Future<void> searchMovie(String text) async {
    searchDebounce?.cancel();
    searchDebounce = Timer(Duration(milliseconds: 321), () async {
      final searchQuery = text.isNotEmpty ? text : null;
      if (searchQuery == _searchQueryText) return;
      _searchQueryText = searchQuery;
      _movies.clear();
      if (isSearchMode) {
        await _searchMoviePaginator.resetCurrentData();
      }
      _loadMoviesFromPage();
    });
    // final searchQuery = text.isNotEmpty ? text : null;
    // if (searchQuery == _searchQueryText) return;
    // _searchQueryText = searchQuery;
    // await resetList();
  }

  Future<void> _resetList() async {
    await _popularMoviePaginator.resetCurrentData();
    await _searchMoviePaginator.resetCurrentData();
    _movies.clear();
    await _loadMoviesFromPage();
  }
}


//38