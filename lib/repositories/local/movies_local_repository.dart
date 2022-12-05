import 'package:imdb_clone/objectbox.g.dart';
import 'package:imdb_clone/repositories/local/dao/movie_dao.dart';
import 'package:imdb_clone/repositories/local/interfaces/i_movies_local_repository.dart';
import 'package:objectbox/objectbox.dart';

class MoviesLocalRepository implements IMoviesLocalRepository {
  final Store store;
  late final Box<MovieDao> _box;

  MoviesLocalRepository({required this.store}) {
    _box = store.box<MovieDao>();
  }

  @override
  void addMovies(List<MovieDao> movies) {
    _box.putMany(movies);
  }

  @override
  void clearMovies() {
    _box.removeAll();
  }

  @override
  List<MovieDao> getAllMovies() {
    final query = (_box.query()..order(MovieDao_.orderNumber)).build();
    final movies = query.find();
    query.close();
    return movies;
  }

  @override
  List<MovieDao> getMoviesWithIds(List<int> ids) {
    final query = (_box.query(MovieDao_.id.oneOf(ids))..order(MovieDao_.orderNumber)).build();
    final movies = query.find();
    query.close();
    return movies;
  }

  @override
  int getMaxOrderNumber() {
    final query = _box.query().build();
    final maxOrderNumber = query.property<int>(MovieDao_.orderNumber).max();
    query.close();
    return maxOrderNumber;
  }
}
