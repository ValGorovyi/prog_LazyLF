import 'package:flutter/material.dart';

class MainScreenW extends StatefulWidget {
  const MainScreenW({super.key});

  @override
  State<MainScreenW> createState() => _MainScreenW();
}

class _MainScreenW extends State<MainScreenW> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TMDB')),
      body: Center(child: Text('demo started text in main')),
    );
  }
}
