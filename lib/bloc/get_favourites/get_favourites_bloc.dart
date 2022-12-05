import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:imdb_clone/bloc/mappers/movie_mapper.dart';
import 'package:imdb_clone/common/const.dart';
import 'package:imdb_clone/models/movie.dart';
import 'package:imdb_clone/repositories/local/dao/movie_dao.dart';
import 'package:imdb_clone/repositories/local/interfaces/i_favourites_local_repository.dart';
import 'package:imdb_clone/repositories/local/interfaces/i_movies_local_repository.dart';

part 'get_favourites_event.dart';
part 'get_favourites_state.dart';

class GetFavouritesBloc extends Bloc<GetFavouritesEvent, GetFavouritesState> {
  final IFavouritesLocalRepository _favouritesLocalRepository;
  final IMoviesLocalRepository _moviesLocalRepository;

  GetFavouritesBloc(
    this._favouritesLocalRepository,
    this._moviesLocalRepository,
  ) : super(const GetFavouritesState()) {
    on<GetFavouriteMoviesEvent>(_mapGetFavouriteMoviesEvent);
  }

  void _mapGetFavouriteMoviesEvent(GetFavouriteMoviesEvent event, Emitter<GetFavouritesState> emit) async {
    await emit.forEach<List<int>>(_favouritesLocalRepository.getUpdatesForFavourite(),
        onData: (ids) {
          final List<MovieDao> moviesDao = _moviesLocalRepository.getMoviesWithIds(ids);
          final List<Movie> movies = moviesDao
              .map((item) =>
                  mapMovie(item, "$baseImageUrl$profilePictureParameter", "$baseImageUrl$backdropPictureParameter"))
              .toList();
          return state.copyWith(
            status: GetFavouritesStatus.fetched,
            movies: movies,
          );
        },
        onError: (_, __) => state.copyWith(status: GetFavouritesStatus.error));
  }
}
