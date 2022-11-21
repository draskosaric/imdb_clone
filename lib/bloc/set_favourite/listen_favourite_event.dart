part of 'listen_favourite_bloc.dart';

abstract class ListenFavouriteEvent extends Equatable {
  const ListenFavouriteEvent();
}

class ListFavouriteEventRequested extends ListenFavouriteEvent {
  final int movieId;

  const ListFavouriteEventRequested({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}

class ChangeFavouriteEvent extends ListenFavouriteEvent {
  final int movieId;

  const ChangeFavouriteEvent({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}
