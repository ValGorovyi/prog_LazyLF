import 'package:flutter/material.dart';
import 'package:prog_lazy_f/appModel/appModel.dart' show AppModel;
import 'package:prog_lazy_f/navigation/mainNavigation.dart' show MainNavigation;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final model = AppModel();
  await model.checkAuth();
  runApp(UpperW(model: model));
}

class UpperW extends StatelessWidget {
  final AppModel model;
  static final mainNavigation = MainNavigation();
  const UpperW({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 4, 49, 126),
          foregroundColor: Colors.white,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 24),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Colors.blueAccent),
            foregroundColor: WidgetStateProperty.all(Colors.white),

            // padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsetsGeometry.symmetric(horizontal: 10))
            textStyle: WidgetStateProperty.all<TextStyle>(
              TextStyle(fontSize: 18),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
            foregroundColor: WidgetStateProperty.all<Color>(Colors.blueAccent),
            textStyle: WidgetStateProperty.all<TextStyle>(
              TextStyle(fontSize: 18),
            ),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color.fromARGB(255, 4, 49, 126),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
        textTheme: TextTheme(displayMedium: TextStyle(fontSize: 16)),

        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: AuthorizW(),
      initialRoute: mainNavigation.initialRoute(model.isAuth),
      routes: mainNavigation.routes,
      onGenerateRoute: mainNavigation.onGererateRoutes,
      // (RouteSettings setting) {
      //   return MaterialPageRoute<void>(
      //     builder: (context) {
      //       return Scaffold(
      //         body: Center(
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Text('navigation error. 404. not found'),
      //               ElevatedButton(
      //                 onPressed: () {
      //                   if (Navigator.of(context).canPop()) {
      //                     Navigator.of(context).pop();
      //                   }
      //                 },
      //                 child: Text('To back page'),
      //               ),
      //             ],
      //           ),
      //         ),
      //       );
      //     },
      //   );
      // },
    );
  }
}
