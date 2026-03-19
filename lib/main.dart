import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show
        GlobalMaterialLocalizations,
        GlobalWidgetsLocalizations,
        GlobalCupertinoLocalizations;
import 'package:prog_lazy_f/appModel/appModel.dart' show AppModel;
import 'package:prog_lazy_f/navigation/mainNavigation.dart' show MainNavigation;
import 'package:prog_lazy_f/universalInherit/universalInheritProvider.dart'
    show UniversalInheritProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final model = AppModel();
  await model.checkAuth();
  const app = UpperW();
  final widget = UniversalInheritProvider(model: model, child: app);
  runApp(widget);
}

class UpperW extends StatelessWidget {
  static final mainNavigation = MainNavigation();
  const UpperW({super.key});
  @override
  Widget build(BuildContext context) {
    final model = UniversalInheritProvider.read<AppModel>(context);
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
      initialRoute: mainNavigation.initialRoute(model?.isAuth == true),
      routes: mainNavigation.routes,
      onGenerateRoute: mainNavigation.onGererateRoutes,
    );
  }
}
