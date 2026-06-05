import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show BuildContext, IconData, Icons;
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

class MovieCardDetailsData {
  String title = '';
  bool isLoading = true;
  String overview = '';
  TopPosterImageData posterData = TopPosterImageData();
}

class TopPosterImageData {
  final String? backdropPath;
  final String? posterPath;
  final IconData favoriteIcon;
  TopPosterImageData({
    this.favoriteIcon = Icons.favorite_border_outlined,
    this.backdropPath,
    this.posterPath,
  });
}

class MovieCardDetailsModel extends ChangeNotifier {
  final _movieApiCl = MovieApiClient();
  final _accountApiCl = AccountApiClient();
  final _sessionDataPr = SessionDataProvider();
  final _authService = AuthService();
  final int movieId;
  String _locale = '';
  MovieDetailsType? _movieDetailsTypeDatas;
  late DateFormat _dateFormat;
  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;
  MovieCardDetailsModel(this.movieId);
  MovieDetailsType? get movieDetails => _movieDetailsTypeDatas;
  final dataCard = MovieCardDetailsData();
  Future<void> setupLocate(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMd(_locale);
    updateData(null, false);
    await loadDetails(context);
  }

  String stringFromDate(DateTime? date) {
    return date != null ? _dateFormat.format(date) : '';
  }

  Future<void> loadDetails(BuildContext context) async {
    try {
      _movieDetailsTypeDatas = await _movieApiCl.movieDetails(movieId, _locale);
      final sessionId = await _sessionDataPr.getSessionId();
      if (sessionId != null) {
        _isFavorite = await _movieApiCl.isFavorire(movieId, sessionId);
      }
      updateData(_movieDetailsTypeDatas, _isFavorite);
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
  }

  void updateData(MovieDetailsType? details, bool isFavorite) {
    dataCard.title = details?.title ?? 'Loading...';
    dataCard.isLoading = details == null;
    if (details == null) {
      notifyListeners();
      return;
    }
    dataCard.overview = details.overview ?? '';
    final iconData = isFavorite
        ? Icons.favorite
        : Icons.favorite_border_outlined;
    dataCard.posterData = TopPosterImageData(
      favoriteIcon: iconData,
      backdropPath: details.backdropPath,
      posterPath: details.posterPath,
    );
    notifyListeners();
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
