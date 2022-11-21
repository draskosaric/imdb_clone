part of 'fetch_popular_bloc.dart';

enum FetchPopularStatus {
  initial,
  fetchPopularLoading,
  fetchPopularFinishedOffline,
  fetchPopularFinished,
  fetchPopularError,
  favouriteFlagChanged,
}

extension FetchPopularX on FetchPopularStatus {
  bool get isInitial => this == FetchPopularStatus.initial;
  bool get isFetchPopularLoading => this == FetchPopularStatus.fetchPopularLoading;
  bool get isFetchPopularFinishedOffline => this == FetchPopularStatus.fetchPopularFinishedOffline;
  bool get isFetchPopularFinished => this == FetchPopularStatus.fetchPopularFinished;
  bool get isFetchPopularError => this == FetchPopularStatus.fetchPopularError;
  bool get isFavouriteFlagChanged => this == FetchPopularStatus.favouriteFlagChanged;
}

class FetchPopularState extends Equatable {
  final FetchPopularStatus status;
  final int page;
  final List<Movie> movies;
  final bool hasReachedMax;
  final List<int> favourites;

  const FetchPopularState({
    this.status = FetchPopularStatus.initial,
    int? page,
    List<Movie>? movies,
    bool? hasReachedMax,
    List<int>? favourites,
  })  : page = page ?? 1,
        movies = movies ?? const [],
        favourites = favourites ?? const [],
        hasReachedMax = hasReachedMax ?? false;

  FetchPopularState copyWith({
    FetchPopularStatus? status,
    int? page,
    List<Movie>? movies,
    bool? hasReachedMax,
    List<int>? favourites,
  }) =>
      FetchPopularState(
        status: status ?? this.status,
        page: page ?? this.page,
        movies: movies ?? this.movies,
        favourites: favourites ?? this.favourites,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      );

  @override
  List<Object> get props => [status, page, hasReachedMax, movies, favourites];

  @override
  String toString() =>
      "FetchPopularState: $status, page: $page, movies.count: ${movies.length}, hasReachedMax: $hasReachedMax";
}
