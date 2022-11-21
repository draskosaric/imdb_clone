import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_clone/bloc/fetch_popular/fetch_popular_bloc.dart';
import 'package:imdb_clone/common/colors.dart';
import 'package:imdb_clone/common/themes.dart';
import 'package:imdb_clone/main.dart';
import 'package:imdb_clone/models/movie.dart';
import 'package:imdb_clone/presentation/widgets/error_app_widget.dart';
import 'package:imdb_clone/presentation/widgets/loadin_widget.dart';
import 'package:imdb_clone/presentation/widgets/movie_list_item.dart';
import 'package:imdb_clone/repositories/local/favourites_local_repository.dart';
import 'package:imdb_clone/repositories/local/genre_local_repository.dart';
import 'package:imdb_clone/repositories/local/movies_local_repository.dart';
import 'package:imdb_clone/repositories/local/shared_prefs_repository.dart';
import 'package:imdb_clone/repositories/remote/dio_client.dart';
import 'package:imdb_clone/repositories/remote/remote_genres_repository.dart';
import 'package:imdb_clone/repositories/remote/remote_movies_repository.dart';

class PopularMoviesList extends StatefulWidget {
  const PopularMoviesList({super.key});

  @override
  State<PopularMoviesList> createState() => _PopularMoviesListState();
}

class _PopularMoviesListState extends State<PopularMoviesList> {
  final _scrollController = ScrollController();
  final _bloc = FetchPopularBloc(
    SharedPreferencesRepository(),
    RemoteGenresRepository(api: DioClient().dio),
    RemoteMoviesRepository(api: DioClient().dio),
    MoviesLocalRepository(store: objectbox.store),
    GenreLocalRepository(store: objectbox.store),
    FavouritesLocalRepository(store: objectbox.store),
  );

  _PopularMoviesListState() {
    _scrollController.addListener(_onScroll);
    _bloc.add(const FetchPopularMoviesEvent());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
    if (!_bloc.isClosed) {
      _bloc.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _bloc,
      listener: (context, state) {
        if ((state as FetchPopularState).status.isFetchPopularFinishedOffline) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Please, check your connection", style: snackBarTextStyle(context)),
              duration: const Duration(seconds: 5),
              backgroundColor: AppColors.qDefaultColor,
            ),
          );
        }
      },
      builder: (context, state) {
        return BlocBuilder(
          bloc: _bloc,
          builder: (BuildContext context, FetchPopularState state) {
            if (state.status.isInitial) {
              return const LoadingWidget();
            }
            if (state.status.isFetchPopularError) {
              return const ErrorAppWidget();
            }

            return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) => index >= state.movies.length
                  ? Center(
                      child: SizedBox(
                        width: 33,
                        height: 33,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.5,
                          color: AppColors.qDefaultColor,
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: MovieListItem(
                        movie: state.movies[index],
                        onTap: (Movie movie) {
                          context.push("/details", extra: movie);
                        },
                      ),
                    ),
              itemCount: state.hasReachedMax || state.status.isFetchPopularFinishedOffline
                  ? state.movies.length
                  : state.movies.length + 1,
              controller: _scrollController,
            );
          },
        );
      },
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _bloc.add(const FetchPopularMoviesEvent());
    }
  }
}
