part of 'get_favourites_bloc.dart';

abstract class GetFavouritesEvent extends Equatable {
  const GetFavouritesEvent();

  @override
  List<Object> get props => [];
}

class GetFavouriteMoviesEvent extends GetFavouritesEvent {
  const GetFavouriteMoviesEvent();
}
