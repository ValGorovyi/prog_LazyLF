import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter/widgets.dart' show Localizations;
import 'package:intl/intl.dart';
import 'package:prog_lazy_f/domain/apiClient/apiClient.dart';
import 'package:prog_lazy_f/domain/apiClient/dataProvider.dart';
import 'package:prog_lazy_f/domain/entity/movieDetails.dart'
    show MovieDetailsType;

class MovieCardDetailsModel extends ChangeNotifier {
  final _apiCl = ApiClient();
  final _sessionDataPr = SessionDataProvider();
  final int movieId;
  String _locale = '';
  MovieDetailsType? _MovieDetailsType;
  MovieCardDetailsModel(this.movieId);
  late DateFormat _dateFormat;
  MovieDetailsType? get movieDetails => _MovieDetailsType;
  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  Future<void> setupLocate(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMd(_locale);
    await loadDetails();
  }

  String stringFromDate(DateTime? date) {
    return date != null ? _dateFormat.format(date) : '';
  }

  Future<void> loadDetails() async {
    _MovieDetailsType = await _apiCl.movieDetails(movieId, _locale);
    final sessionId = await _sessionDataPr.getSessionId();
    print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    print(sessionId);
    print(movieId);
    if (sessionId != null) {
      _isFavorite = await _apiCl.isFavorire(movieId, sessionId);
    }
    notifyListeners();
  }
}
