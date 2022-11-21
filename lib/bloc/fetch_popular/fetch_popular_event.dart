part of 'fetch_popular_bloc.dart';

abstract class FetchPopularEvent extends Equatable {
  const FetchPopularEvent();

  @override
  List<Object> get props => [];
}

class FetchPopularMoviesEvent extends FetchPopularEvent {
  const FetchPopularMoviesEvent();
}
