import 'package:flutter/material.dart';

import 'package:prog_lazy_f/domain/apiClient/dataProvider.dart';
import 'package:prog_lazy_f/domain/factoryes/screenFactory.dart'
    show ScreenFactory;
import 'package:prog_lazy_f/navigation/mainNavigation.dart';

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

  // final movieListM = movieCardsListModel();
  final _screenFactory = ScreenFactory();

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   movieListM.setupLocate(context);
  //   // movieListM.loadMovies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TMDB'),
        actions: [
          IconButton(
            // demo code
            onPressed: () {
              SessionDataProvider().deleteSessionId();
              MainNavigation.resetNavigatot(context);
            },
            //
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _screenFactory.createMovieListW(),
          _screenFactory.createNewsW(),
          _screenFactory.createAboutUsW(),
        ],
      ),
      // body: Center(child: _ontaperWidget[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => onTapItemBar(index),
        items: const [
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
