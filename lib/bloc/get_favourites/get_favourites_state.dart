part of 'get_favourites_bloc.dart';

enum GetFavouritesStatus {
  initial,
  loading,
  fetched,
  error,
}

extension GetFavouritesX on GetFavouritesStatus {
  bool get isInitial => this == GetFavouritesStatus.initial;
  bool get isLoading => this == GetFavouritesStatus.loading;
  bool get isFetched => this == GetFavouritesStatus.fetched;
  bool get isError => this == GetFavouritesStatus.error;
}

class GetFavouritesState extends Equatable {
  final GetFavouritesStatus status;
  final List<Movie> movies;

  const GetFavouritesState({
    this.status = GetFavouritesStatus.initial,
    List<Movie>? movies,
  }) : movies = movies ?? const [];

  GetFavouritesState copyWith({
    GetFavouritesStatus? status,
    List<Movie>? movies,
  }) =>
      GetFavouritesState(
        status: status ?? this.status,
        movies: movies ?? this.movies,
      );

  @override
  List<Object> get props => [status, movies];
}
