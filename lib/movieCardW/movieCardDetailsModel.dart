import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter/widgets.dart' show Localizations;
import 'package:intl/intl.dart';
import 'package:prog_lazy_f/domain/apiClient/accountApiClient.dart'
    show AccountApiClient, MediaType;
import 'package:prog_lazy_f/domain/apiClient/movieApiClient.dart';
import 'package:prog_lazy_f/domain/apiClient/apiClientExeption.dart'
    show ApiClientExeptionType, ApiClientExeption;
import 'package:prog_lazy_f/domain/apiClient/dataProvider.dart';
import 'package:prog_lazy_f/domain/entity/movieDetails.dart'
    show MovieDetailsType;
import 'package:prog_lazy_f/navigation/mainNavigation.dart';
import 'package:prog_lazy_f/services/authService.dart' show AuthService;

class MovieCardDetailsModel extends ChangeNotifier {
  final _movieApiCl = MovieApiClient();
  final _accountApiCl = AccountApiClient();
  final _sessionDataPr = SessionDataProvider();
  final _authService = AuthService();
  final int movieId;
  String _locale = '';
  MovieDetailsType? _MovieDetailsType;
  late DateFormat _dateFormat;
  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;
  // Future<void>? Function()? onSessionExpired;
  MovieCardDetailsModel(this.movieId);
  MovieDetailsType? get movieDetails => _MovieDetailsType;

  Future<void> setupLocate(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMd(_locale);
    await loadDetails(context);
  }

  String stringFromDate(DateTime? date) {
    return date != null ? _dateFormat.format(date) : '';
  }

  Future<void> loadDetails(BuildContext context) async {
    try {
      _MovieDetailsType = await _movieApiCl.movieDetails(movieId, _locale);
      final sessionId = await _sessionDataPr.getSessionId();
      if (sessionId != null) {
        _isFavorite = await _movieApiCl.isFavorire(movieId, sessionId);
      }
      notifyListeners();
    } on ApiClientExeption catch (e) {
      _handleApiClientExeption(e, context);
    }
  }

  Future<void> toggleFavorite(BuildContext context) async {
    final sessionId = await _sessionDataPr.getSessionId();
    final accId = await _sessionDataPr.getAccountId();
    if (accId == null || sessionId == null) return;
    final newValueIsFavorite = !isFavorite;

    _isFavorite = newValueIsFavorite;
    notifyListeners();
    try {
      await _accountApiCl.markAsFavorite(
        accountId: accId,
        sessionId: sessionId,
        mediaType: MediaType.Movie,
        mediaId: movieId,
        favorite: newValueIsFavorite,
      );
    } on ApiClientExeption catch (e) {
      _handleApiClientExeption(e, context);
    }
    // catch (e) {
    //   print('????????????????????????????????');
    //   print(e);
    // }
  }

  void _handleApiClientExeption(
    ApiClientExeption exeption,
    BuildContext context,
  ) {
    switch (exeption.type) {
      case ApiClientExeptionType.SessionExpired:
        _authService.logoutMethod();
        MainNavigation.resetNavigatot(context);
        break;
      default:
        print(exeption);
    }
  }
}
