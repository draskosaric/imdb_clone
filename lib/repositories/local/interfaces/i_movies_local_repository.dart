import 'package:imdb_clone/repositories/local/dao/movie_dao.dart';

abstract class IMoviesLocalRepository {
  void addMovies(List<MovieDao> movies);
  void clearMovies();
  List<MovieDao> getAllMovies();
  List<MovieDao> getMoviesWithIds(List<int> ids);
  int getMaxOrderNumber();
}
