import 'package:flutter/material.dart';
import 'package:imdb_clone/common/themes.dart';
import 'package:imdb_clone/presentation/screens/favourites_page.dart';
import 'package:imdb_clone/presentation/widgets/popular_movies_list.dart';

enum ListMoviesType {
  popular,
  favourites,
}

class ListMoviesPage extends StatelessWidget {
  final ListMoviesType listType;

  const ListMoviesPage({
    required this.listType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 36,
          ),
          Image.asset(
            "assets/icons/q_logo.png",
            width: 40,
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            listType == ListMoviesType.popular ? "Popular" : "Favourites",
            style: titleSectionTextStyle(context),
          ),
          const SizedBox(
            height: 16,
          ),
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Expanded(
              child: (listType == ListMoviesType.popular) ? const PopularMoviesList() : const FavouritesPage(),
            ),
          ),
        ],
      ),
    );
  }
}
