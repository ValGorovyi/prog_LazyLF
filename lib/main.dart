import 'package:flutter/material.dart';
import 'package:prog_lazy_f/authW/authW.dart';

void main() {
  runApp(const UpperThemeW());
}

class UpperThemeW extends StatelessWidget {
  const UpperThemeW({super.key});

  // This widget is the root of your application.
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
        textTheme: TextTheme(displayMedium: TextStyle(fontSize: 16)),

        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: AuthorizW(),
      // routes: {
      //   '/': (BuildContext context) => AuthorizW(),
      //   // '/main' : () => {}(),
      // },
    );
  }
}
