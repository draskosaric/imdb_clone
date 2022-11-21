import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:imdb_clone/repositories/local/favourites_local_repository.dart';

part 'listen_favourite_event.dart';
part 'listen_favourite_state.dart';

class ListenFavouriteBloc extends Bloc<ListenFavouriteEvent, ListenFavouriteState> {
  final FavouritesLocalRepository _favouritesLocalRepository;

  ListenFavouriteBloc(this._favouritesLocalRepository) : super(const ListenFavouriteState()) {
    on<ListFavouriteEventRequested>(_mapListenFavouriteEvent);
    on<ChangeFavouriteEvent>(_mapChangeFavouriteEvent);
  }

  Future<void> _mapListenFavouriteEvent(ListFavouriteEventRequested event, Emitter<ListenFavouriteState> emit) async {
    await emit.forEach<bool>(_favouritesLocalRepository.getUpdatesForMovieFavourite(event.movieId),
        onData: (isFave) => state.copyWith(status: ListenFavouriteStatus.fetched, isFavourite: isFave),
        onError: (_, __) => state.copyWith(status: ListenFavouriteStatus.error));
  }

  Future<void> _mapChangeFavouriteEvent(ChangeFavouriteEvent event, Emitter<ListenFavouriteState> emit) async {
    await _favouritesLocalRepository.addOrRemoveFavourite(event.movieId);
  }
}
