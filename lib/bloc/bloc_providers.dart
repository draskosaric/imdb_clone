import 'package:dio/dio.dart';
import 'package:flutter_bloc/src/repository_provider.dart';
import 'package:imdb_clone/objectbox.g.dart';
import 'package:imdb_clone/repositories/local/favourites_local_repository.dart';
import 'package:imdb_clone/repositories/local/genre_local_repository.dart';
import 'package:imdb_clone/repositories/local/movies_local_repository.dart';
import 'package:imdb_clone/repositories/local/token_repository.dart';
import 'package:imdb_clone/repositories/remote/remote_genres_repository.dart';
import 'package:imdb_clone/repositories/remote/remote_movies_repository.dart';

List<RepositoryProviderSingleChildWidget> repositoryProviders(Dio api, Store store) {
  return [
    RepositoryProvider<RemoteGenresRepository>(create: (ctx) => RemoteGenresRepository(api: api)),
    RepositoryProvider<RemoteMoviesRepository>(create: (ctx) => RemoteMoviesRepository(api: api)),
    RepositoryProvider<TokenRepository>(create: (ctx) => TokenRepository()),
    RepositoryProvider<MoviesLocalRepository>(create: (ctx) => MoviesLocalRepository(store: store)),
    RepositoryProvider<GenreLocalRepository>(create: (ctx) => GenreLocalRepository(store: store)),
    RepositoryProvider<FavouritesLocalRepository>(create: (ctx) => FavouritesLocalRepository(store: store)),
  ];
}
