import 'package:flutter/material.dart';
import 'package:prog_lazy_f/cardsList/cardsList.dart';

class MainScreenW extends StatefulWidget {
  const MainScreenW({super.key});

  @override
  State<MainScreenW> createState() => _MainScreenW();
}

class _MainScreenW extends State<MainScreenW> {
  int _selectedIndex = 0;
  void onTapItemBar(int index) {
    if (index == _selectedIndex) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _ontaperWidget = [
    MoviCards(),
    const Text('News'),
    const Text('About us'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TMDB')),
      body: Center(child: _ontaperWidget[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => onTapItemBar(index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Movi'),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'News'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_brightness),
            label: 'About us',
          ),
        ],
      ),
    );
  }
}
