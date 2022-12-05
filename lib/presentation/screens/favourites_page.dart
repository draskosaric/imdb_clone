import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_clone/bloc/get_favourites/get_favourites_bloc.dart';
import 'package:imdb_clone/common/themes.dart';
import 'package:imdb_clone/models/movie.dart';
import 'package:imdb_clone/presentation/widgets/error_app_widget.dart';
import 'package:imdb_clone/presentation/widgets/loadin_widget.dart';
import 'package:imdb_clone/presentation/widgets/movie_list_item.dart';
import 'package:imdb_clone/repositories/local/favourites_local_repository.dart';
import 'package:imdb_clone/repositories/local/movies_local_repository.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetFavouritesBloc(
        RepositoryProvider.of<FavouritesLocalRepository>(context),
        RepositoryProvider.of<MoviesLocalRepository>(context),
      )..add(const GetFavouriteMoviesEvent()),
      child: BlocBuilder<GetFavouritesBloc, GetFavouritesState>(
        buildWhen: (previous, current) => previous != current,
        builder: (BuildContext context, GetFavouritesState state) {
          if (state.status.isLoading) {
            return const LoadingWidget();
          }
          if (state.status.isError) {
            return const ErrorAppWidget();
          }
          if (state.status.isFetched) {
            if (state.movies.isEmpty) {
              return Center(
                child: Text(
                  "No favourites yet",
                  style: movieTitleListTextStyle(context),
                ),
              );
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) => Container(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: MovieListItem(
                  key: Key(state.movies[index].id.toString()),
                  movie: state.movies[index],
                  onTap: (Movie movie) {
                    context.push("/details", extra: movie);
                  },
                ),
              ),
              itemCount: state.movies.length,
            );
          }
          return Container();
        },
      ),
    );
  }
}
