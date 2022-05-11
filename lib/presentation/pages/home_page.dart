import 'package:dicoding_mfde_submission/common/constants.dart';
import 'package:dicoding_mfde_submission/presentation/pages/about_page.dart';
import 'package:dicoding_mfde_submission/presentation/pages/home_movie_page.dart';
import 'package:dicoding_mfde_submission/presentation/pages/search_page.dart';
import 'package:dicoding_mfde_submission/presentation/pages/home_tv_page.dart';
import 'package:dicoding_mfde_submission/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  final List<Widget> _listWidget = [
    const HomeMoviePage(),
    const HomeTvPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: const Icon(Icons.movie),
      label: movies.toUpperCase(),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.tv),
      label: tvShows.toUpperCase(),
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: _buildDrawer(context),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.routeName,
                  arguments: (_bottomNavIndex == 0) ? movies : tvShows);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
        selectedItemColor: Colors.lightGreenAccent,
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Column(
      children: [
        const UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('assets/circle-g.png'),
          ),
          accountName: Text('Ditonton'),
          accountEmail: Text('ditonton@dicoding.com'),
        ),
        ListTile(
          leading: const Icon(Icons.movie),
          title: const Text('Movies'),
          onTap: () {
            _onBottomNavTapped(0);
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.tv),
          title: const Text('Tv Shows'),
          onTap: () {
            _onBottomNavTapped(1);
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.save_alt),
          title: const Text('Watchlist'),
          onTap: () {
            Navigator.pushNamed(context, WatchlistPage.routeName);
          },
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, AboutPage.routeName);
          },
          leading: const Icon(Icons.info_outline),
          title: const Text('About'),
        ),
      ],
    );
  }
}
