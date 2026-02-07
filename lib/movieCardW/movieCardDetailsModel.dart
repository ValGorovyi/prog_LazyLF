import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter/widgets.dart' show Localizations;
import 'package:intl/intl.dart';
import 'package:prog_lazy_f/domain/apiClient/apiClient.dart';
import 'package:prog_lazy_f/domain/entity/movieDetails.dart'
    show MovieDetailsType;

class MovieCardDetailsModel extends ChangeNotifier {
  final _apiCl = ApiClient();
  final int movieId;
  String _locale = '';
  MovieDetailsType? _MovieDetailsType;
  MovieCardDetailsModel(this.movieId);
  late DateFormat _dateFormat;
  MovieDetailsType? get movieDetails => _MovieDetailsType;

  Future<void> setupLocate(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMd(_locale);
    await loadDetails();
  }

  Future<void> loadDetails() async {
    _MovieDetailsType = await _apiCl.movieDetails(movieId, _locale);
    notifyListeners();
  }
}
