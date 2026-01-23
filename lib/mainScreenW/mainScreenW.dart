import 'package:flutter/material.dart';
import 'package:prog_lazy_f/cardsList/cardsList.dart';
import 'package:prog_lazy_f/cardsList/movieCardsListModel.dart'
    show movieCardsListModel;
import 'package:prog_lazy_f/domain/apiClient/dataProvider.dart';
import 'package:prog_lazy_f/universalInherit/universalInheritNotifier.dart'
    show UniversalInheritNitifier;

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

  @override
  void initState() {
    super.initState();
    movieListM.loadMovies();
  }

  final movieListM = movieCardsListModel();
  // static final List<Widget> _ontaperWidget = [
  //   MovieCards(),
  //   const Text('News'),
  //   const Text('About us'),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TMDB'),
        actions: [
          IconButton(
            // demo code
            onPressed: () => SessionDataProvider().setSessionId(null),
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          UniversalInheritNitifier(
            model: movieListM,
            child: const MovieCards(),
          ),
          const Text('News'),
          const Text('About us'),
        ],
      ),
      // body: Center(child: _ontaperWidget[_selectedIndex]),
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
