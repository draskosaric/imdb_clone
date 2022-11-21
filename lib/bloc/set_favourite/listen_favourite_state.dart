part of 'listen_favourite_bloc.dart';

enum ListenFavouriteStatus {
  initial,
  loading,
  fetched,
  error,
}

extension ListenFavouriteX on ListenFavouriteStatus {
  bool get isInitial => this == ListenFavouriteStatus.initial;
  bool get isLoading => this == ListenFavouriteStatus.loading;
  bool get isFetched => this == ListenFavouriteStatus.fetched;
  bool get isError => this == ListenFavouriteStatus.error;
}

class ListenFavouriteState extends Equatable {
  final ListenFavouriteStatus status;
  final bool? isFavourite;

  const ListenFavouriteState({
    this.status = ListenFavouriteStatus.initial,
    bool? isFavourite,
  }) : isFavourite = isFavourite ?? false;

  ListenFavouriteState copyWith({
    ListenFavouriteStatus? status,
    bool? isFavourite,
  }) =>
      ListenFavouriteState(
        status: status ?? this.status,
        isFavourite: isFavourite ?? this.isFavourite,
      );

  @override
  List<Object?> get props => [status, isFavourite];
}
