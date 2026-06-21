// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show BuildContext, IconData, Icons;
import 'package:flutter/widgets.dart' show Localizations;
import 'package:intl/intl.dart';

import 'package:prog_lazy_f/domain/apiClient/apiClientExeption.dart'
    show ApiClientExeptionType, ApiClientExeption;
import 'package:prog_lazy_f/domain/entity/movieDetails.dart'
    show MovieDetailsType;
import 'package:prog_lazy_f/navigation/mainNavigation.dart';
import 'package:prog_lazy_f/services/authService.dart' show AuthService;
import 'package:prog_lazy_f/services/movieService.dart' show MovieService;

class MovieCardDetailsData {
  String title = '';
  bool isLoading = true;
  String overview = '';
  TopPosterImageData posterData = TopPosterImageData();
  AboutMovieNameData aboutNameData = AboutMovieNameData(name: '', year: '');
  AboutMovieScoreData aboutScoreData = AboutMovieScoreData(voteAverage: 0);
  String summaryData = '';
  List<List<DetailsEmployeeData>> employeeData =
      const <List<DetailsEmployeeData>>[];
  List<ActorScrolinMoviegData> actotsData = const <ActorScrolinMoviegData>[];
}

class TopPosterImageData {
  final String? backdropPath;
  final String? posterPath;
  final bool isFavorite;
  IconData get favoriteIcon =>
      isFavorite ? Icons.favorite : Icons.favorite_border_outlined;
  TopPosterImageData({
    this.backdropPath,
    this.posterPath,
    this.isFavorite = false,
  });

  TopPosterImageData copyWith({
    String? backdropPath,
    String? posterPath,
    bool? isFavorite,
  }) {
    return TopPosterImageData(
      backdropPath: backdropPath ?? this.backdropPath,
      posterPath: posterPath ?? this.posterPath,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class AboutMovieNameData {
  final String name;
  final String year;

  AboutMovieNameData({required this.name, required this.year});
}

class AboutMovieScoreData {
  final String? trailerKey;
  final double voteAverage;

  AboutMovieScoreData({this.trailerKey, required this.voteAverage});
}

class DetailsEmployeeData {
  final String name;
  final String job;

  DetailsEmployeeData({required this.name, required this.job});
}

class ActorScrolinMoviegData {
  final String name;

  final String character;
  final String? profilePath;

  ActorScrolinMoviegData({
    required this.name,
    required this.character,
    required this.profilePath,
  });
}

class MovieCardDetailsModel extends ChangeNotifier {
  final _movieService = MovieService();
  final _authService = AuthService();
  final int movieId;
  String _locale = '';
  late DateFormat _dateFormat;

  MovieCardDetailsModel(this.movieId);
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
      final details = await _movieService.loadDetails(
        locale: _locale,
        movieId: movieId,
      );

      updateData(details.details, details.isFavorite);
    } on ApiClientExeption catch (e) {
      _handleApiClientExeption(e, context);
    }
  }

  Future<void> toggleFavorite(BuildContext context) async {
    dataCard.posterData = dataCard.posterData.copyWith(
      isFavorite: !dataCard.posterData.isFavorite,
    );
    notifyListeners();
    try {
      await _movieService.updateFavorite(
        isFavorite: dataCard.posterData.isFavorite,
        movieId: movieId,
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

    dataCard.posterData = TopPosterImageData(
      isFavorite: isFavorite,
      backdropPath: details.backdropPath,
      posterPath: details.posterPath,
    );
    var yearOfReliase = details.releaseDate?.year.toString();
    yearOfReliase = yearOfReliase != null ? ' ( $yearOfReliase )' : '-0-0-0-';
    dataCard.aboutNameData = AboutMovieNameData(
      name: details.title,
      year: yearOfReliase,
    );
    final videoT = details.videos.results.where(
      (video) => video.site == 'YouTube' && video.type == 'Trailer',
    );

    final trailerKey = videoT.isNotEmpty == true ? videoT.first.key : null;
    dataCard.aboutScoreData = AboutMovieScoreData(
      voteAverage: details.voteAverage,
      trailerKey: trailerKey,
    );
    dataCard.summaryData = makeSummary(details);
    dataCard.employeeData = makeEmployee(details);
    dataCard.actotsData = details.credits.cast
        .map(
          (elem) => ActorScrolinMoviegData(
            character: elem.character,
            name: elem.name,
            profilePath: elem.profilePath,
          ),
        )
        .toList();
    notifyListeners();
  }

  List<List<DetailsEmployeeData>> makeEmployee(MovieDetailsType details) {
    var crew = details.credits.crew
        .map((elem) => DetailsEmployeeData(job: elem.job, name: elem.name))
        .toList();

    crew = crew.length > 4 ? crew.sublist(0, 4) : crew;

    var crewChunks = <List<DetailsEmployeeData>>[];
    for (var i = 0; i < crew.length; i += 2) {
      crewChunks.add(
        crew.sublist(i, i + 2 > crew.length ? crew.length : i + 2),
      );
    }
    return crewChunks;
  }

  String makeSummary(MovieDetailsType details) {
    var listOfTextDetails = <String>[];

    final reliseOfDate = details.releaseDate;
    if (reliseOfDate != null) {
      listOfTextDetails.add(stringFromDate(reliseOfDate));
    }
    if (details.productionCountries.isNotEmpty) {
      listOfTextDetails.add('(${details.productionCountries.first.iso})');
    }
    final runtime = details.runtime ?? 0;
    final durationOfMovie = Duration(minutes: runtime);
    final hours = durationOfMovie.inHours;
    final minutes = durationOfMovie.inMinutes.remainder(60);
    listOfTextDetails.add('$hours h : $minutes m;');
    if (details.genres.isNotEmpty) {
      var listOfGenresName = <String>[];
      for (var genre in details.genres) {
        listOfGenresName.add(genre.name);
      }
      listOfTextDetails.add(listOfGenresName.join(', '));
    }
    return listOfTextDetails.join(' ');
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
