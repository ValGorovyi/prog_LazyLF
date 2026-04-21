import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show
        GlobalMaterialLocalizations,
        GlobalWidgetsLocalizations,
        GlobalCupertinoLocalizations;
import 'package:prog_lazy_f/navigation/mainNavigation.dart'
    show MainNavigation, NavigationRoutesNames;

void main() {
  const app = UpperW();
  runApp(app);
}

class UpperW extends StatelessWidget {
  static final mainNavigation = MainNavigation();
  const UpperW({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('ru'),
      ],
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
      initialRoute: NavigationRoutesNames.loaderRoute,
      routes: mainNavigation.routes,
      onGenerateRoute: mainNavigation.onGererateRoutes,
    );
  }
}
