import 'package:flutter/material.dart' show Widget, MaterialPageRoute;
import 'package:flutter/widgets.dart';
import 'package:prog_lazy_f/domain/factoryes/screenFactory.dart';

abstract class NavigationRoutesNames {
  static const mainRoute = '/main';
  static const authRoute = '/auth';
  static const idRoute = '/main/id';
  static const trailerRoute = '/main/id/trailer';
  static const loaderRoute = '/';
}

class MainNavigation {
  static final _screenFactory = ScreenFactory();
  final routes = <String, Widget Function(BuildContext)>{
    NavigationRoutesNames.loaderRoute: (_) => _screenFactory.createLoaderW(),
    NavigationRoutesNames.authRoute: (_) => _screenFactory.creareAuthW(),
    //list of movie
    NavigationRoutesNames.mainRoute: (_) => _screenFactory.createMainScreenW(),
  };

  Route<Object> onGererateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case NavigationRoutesNames.idRoute:
        final args = settings.arguments;
        final movieId = args is int ? args : 1;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.createMovieCardW(movieId),
        );
      case NavigationRoutesNames.trailerRoute:
        final args = settings.arguments;
        final youtubeKey = args is String ? args : '';
        return MaterialPageRoute(
          builder: (_) => _screenFactory.createMovieTrailerW(youtubeKey),
        );

      default:
        const errWidget = Text('navigation error. 404. not found');
        return MaterialPageRoute(builder: (_) => errWidget);
    }
  }

  static void resetNavigatot(BuildContext context) {
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(NavigationRoutesNames.loaderRoute, (r) => false);
  }
}
