import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:imdb_clone/bloc/mappers/movie_mapper.dart';
import 'package:imdb_clone/common/const.dart';
import 'package:imdb_clone/common/exceptions.dart';
import 'package:imdb_clone/extensions/date_extensions.dart';
import 'package:imdb_clone/models/movie.dart';
import 'package:imdb_clone/repositories/local/dao/movie_dao.dart';
import 'package:imdb_clone/repositories/local/interfaces/i_favourites_local_repository.dart';
import 'package:imdb_clone/repositories/local/interfaces/i_genre_local_repository.dart';
import 'package:imdb_clone/repositories/local/interfaces/i_movies_local_repository.dart';
import 'package:imdb_clone/repositories/local/interfaces/i_shared_preferences_repository.dart';
import 'package:imdb_clone/repositories/remote/dto/movie_simple_dto.dart';
import 'package:imdb_clone/repositories/remote/interfaces/i_remote_genres_repository.dart';
import 'package:imdb_clone/repositories/remote/interfaces/i_remote_movies_repository.dart';

part 'fetch_popular_event.dart';
part 'fetch_popular_state.dart';

class FetchPopularBloc extends Bloc<FetchPopularEvent, FetchPopularState> {
  final ISharedPreferencesRepository _sharedPreferencesRepository;
  final IRemoteGenresRepository _remoteGenresRepository;
  final IRemoteMoviesRepository _remoteMoviesRepository;
  final IMoviesLocalRepository _moviesLocalRepository;
  final IGenreLocalRepository _genreLocalRepository;
  final IFavouritesLocalRepository _favouritesLocalRepository;

  FetchPopularBloc(this._sharedPreferencesRepository, this._remoteGenresRepository, this._remoteMoviesRepository,
      this._moviesLocalRepository, this._genreLocalRepository, this._favouritesLocalRepository)
      : super(const FetchPopularState()) {
    on<FetchPopularMoviesEvent>(_mapFetchPopularEvent, transformer: sequential());
  }

  void _mapFetchPopularEvent(FetchPopularMoviesEvent event, Emitter<FetchPopularState> emit) async {
    emit(state.copyWith(
      status: FetchPopularStatus.fetchPopularLoading,
    ));
    try {
      _fetchGenres();
      final fetchedMovies = await _fetchMovies(state.page);
      emit(
        state.copyWith(
          status: FetchPopularStatus.fetchPopularFinished,
          movies: fetchedMovies
              .map((item) =>
                  mapMovie(item, "$baseImageUrl$profilePictureParameter", "$baseImageUrl$backdropPictureParameter"))
              .toList(),
          hasReachedMax: fetchedMovies.isEmpty,
          page: state.page + 1,
        ),
      );
    } on ImdbCloneException catch (ex) {
      final newStatus = (ex.type == ImdbCloneExceptionType.noConnection)
          ? FetchPopularStatus.fetchPopularFinishedOffline
          : FetchPopularStatus.fetchPopularError;
      emit(state.copyWith(status: newStatus));
    } catch (ex) {
      emit(state.copyWith(status: FetchPopularStatus.fetchPopularError));
    }
  }

  Future<void> _fetchGenres() async {
    final lastGenreFetch = await _sharedPreferencesRepository.getLastGenreFetch();
    if (lastGenreFetch.isToday) return;
    final genreDtos = await _remoteGenresRepository.fetchGenres();
    await _genreLocalRepository.addGenres(genreDtos.map((g) => mapGenreDto(g)).toList());
    await _sharedPreferencesRepository.setLastGenreFetch(DateTime.now());
  }

  Future<List<MovieDao>> _fetchMovies(int page) async {
    final lastMovieFetch = await _sharedPreferencesRepository.getLastMovieFetch();
    if (!lastMovieFetch.isToday) {
      await _sharedPreferencesRepository.setLastPageFetched(0);
      _moviesLocalRepository.clearMovies();
    }
    final lastPageFetched = await _sharedPreferencesRepository.getLastPageFetched();
    if (page > lastPageFetched) {
      final newPage = lastPageFetched + 1;
      List<MovieSimpleDto> moviesDto = await _remoteMoviesRepository.fetchMovies(page: newPage);
      int nextOrderNumber = _moviesLocalRepository.getMaxOrderNumber() + 1;
      List<MovieDao> movies = await Future.wait(
          moviesDto.map((mDto) async => mapByMovieDto(mDto, nextOrderNumber++, _genreLocalRepository)).toList());
      _moviesLocalRepository.addMovies(movies);
      _sharedPreferencesRepository.setLastPageFetched(newPage);
      _sharedPreferencesRepository.setLastMovieFetch(DateTime.now());
    } else {
      emit(state.copyWith(page: lastPageFetched));
    }

    return _moviesLocalRepository.getAllMovies();
  }
}
