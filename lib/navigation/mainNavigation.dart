import 'package:flutter/material.dart' show Widget, MaterialPageRoute;
import 'package:flutter/widgets.dart';
import 'package:prog_lazy_f/authW/authModel.dart' show AuthModel;
import 'package:prog_lazy_f/authW/authW.dart' show AuthorizW;
import 'package:prog_lazy_f/cardsList/movieCardsListModel.dart'
    show movieCardsListModel;
import 'package:prog_lazy_f/mainScreenW/mainScreenW.dart' show MainScreenW;
import 'package:prog_lazy_f/movieCardW/movieCardDetailsModel.dart'
    show MovieCardDetailsModel;
import 'package:prog_lazy_f/movieCardW/movieCardW.dart' show MovieCardW;
import 'package:prog_lazy_f/universalInherit/universalInheritNotifier.dart'
    show UniversalInheritNitifier;

abstract class NavigationRoutesNames {
  static const mainRoute = '/';
  static const authRoute = 'auth';
  static const idRoute = '/id';
}

class MainNavigation {
  final routes = <String, Widget Function(BuildContext)>{
    NavigationRoutesNames.authRoute: (BuildContext context) =>
        UniversalInheritNitifier(create: () => AuthModel(), child: AuthorizW()),
    NavigationRoutesNames.mainRoute: (BuildContext context) =>
        UniversalInheritNitifier(
          create: () => movieCardsListModel(),
          child: MainScreenW(),
        ),
  };
  String initialRoute(bool isAuth) {
    return isAuth
        ? NavigationRoutesNames.mainRoute
        : NavigationRoutesNames.authRoute;
  }

  Route<Object> onGererateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case NavigationRoutesNames.idRoute:
        final args = settings.arguments;
        final movieId = args is int ? args : 1;
        return MaterialPageRoute(
          builder: (context) => UniversalInheritNitifier(
            create: () => MovieCardDetailsModel(movieId),
            child: const MovieCardW(),
          ),
        );
      default:
        const errWidget = Text('navigation error. 404. not found');
        return MaterialPageRoute(builder: (context) => errWidget);
    }
  }
}
