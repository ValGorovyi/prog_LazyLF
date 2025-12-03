import 'package:flutter/material.dart' show Widget, MaterialPageRoute;
import 'package:flutter/widgets.dart';
import 'package:prog_lazy_f/authW/authModel.dart' show AuthInherit, AuthModel;
import 'package:prog_lazy_f/authW/authW.dart' show AuthorizW;
import 'package:prog_lazy_f/mainScreenW/mainScreenW.dart' show MainScreenW;
import 'package:prog_lazy_f/movieCardW/movieCardW.dart' show MovieCarsW;

abstract class NavigationRoutesNames {
  static const mainRoute = '/main';
  static const authRoute = '/auth';
  static const idRoute = 'id';
}

class MainNavigation {
  final routes = <String, Widget Function(BuildContext)>{
    '/auth': (BuildContext context) =>
        AuthInherit(model: AuthModel(), child: AuthorizW()),
    '/main': (BuildContext context) => MainScreenW(),
    // '/main/movieid': (BuildContext context) {
    //   final arguments = ModalRoute.of(context)?.settings.arguments;
    //   if (arguments is int) {
    //     return MovieCarsW(id: arguments);
    //   } else {
    //     return MovieCarsW(id: 1);
    //   }
    // },
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
        return MaterialPageRoute(builder: (context) => MovieCarsW(id: movieId));
      default:
        const errWidget = Text('navigation error. 404. not found');
        return MaterialPageRoute(builder: (context) => errWidget);
    }
  }
}
