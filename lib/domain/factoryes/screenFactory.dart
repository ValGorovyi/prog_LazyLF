import 'package:flutter/material.dart';
import 'package:prog_lazy_f/authW/authModel.dart' show AuthViewModel;
import 'package:prog_lazy_f/authW/authW.dart' show AuthorizW;
import 'package:prog_lazy_f/cardsList/cardsList.dart' show MovieCards;
import 'package:prog_lazy_f/cardsList/movieCardsListModel.dart'
    show MovieCardsListModel;
import 'package:prog_lazy_f/loaderW/loaderModel.dart' show LoaderVieWModel;
import 'package:prog_lazy_f/loaderW/loaderWidget.dart' show LoaderWidget;
import 'package:prog_lazy_f/mainScreenW/mainScreenW.dart' show MainScreenW;
import 'package:prog_lazy_f/movieCardW/movieCardDetailsModel.dart'
    show MovieCardDetailsModel;
import 'package:prog_lazy_f/movieCardW/movieCardW.dart' show MovieCardW;
import 'package:prog_lazy_f/trailerW/trailerW.dart' show MovieTrailerW;

import 'package:provider/provider.dart';

class ScreenFactory {
  Widget createLoaderW() {
    return Provider(
      create: (context) => LoaderVieWModel(context),
      lazy: false,
      child: LoaderWidget(),
    );
  }

  Widget creareAuthW() {
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: AuthorizW(),
    );
  }

  Widget createMainScreenW() {
    return const MainScreenW();
  }

  Widget createMovieCardW(int movieId) {
    return ChangeNotifierProvider(
      create: (_) => MovieCardDetailsModel(movieId),
      child: const MovieCardW(),
    );
  }

  Widget createMovieTrailerW(String youtubeKey) {
    return MovieTrailerW(youtubeKey: youtubeKey);
  }

  Widget createMovieListW() {
    return ChangeNotifierProvider(
      create: (_) => MovieCardsListModel(),
      child: const MovieCards(),
    );
  }

  Widget createNewsW() {
    return const Text('News');
  }

  Widget createAboutUsW() {
    return const Text('About us');
  }
}
