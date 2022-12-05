import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imdb_clone/common/colors.dart';
import 'package:imdb_clone/common/const.dart';
import 'package:imdb_clone/presentation/screens/list_movies_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> screens = [
    const ListMoviesPage(
      listType: ListMoviesType.popular,
    ),
    const ListMoviesPage(
      listType: ListMoviesType.favourites,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.darkDefaultBackgroundColor,
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.movie_outlined),
              label: 'Popular',
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                checkedFavouriteImagePath,
                color: AppColors.qDefaultColor,
                height: 20,
                width: 20,
              ),
              icon: SvgPicture.asset(
                checkedFavouriteImagePath,
                color: Colors.white,
                height: 20,
                width: 20,
              ),
              label: 'Popular',
            ),
          ]),
    );
  }
}
