import 'package:imdb_clone/objectbox.g.dart';
import 'package:imdb_clone/repositories/local/dao/movie_dao.dart';
import 'package:objectbox/objectbox.dart';

class MoviesLocalRepository {
  final Store store;
  late final Box<MovieDao> _box;

  MoviesLocalRepository({required this.store}) {
    _box = store.box<MovieDao>();
  }

  void addMovies(List<MovieDao> movies) {
    _box.putMany(movies);
  }

  void clearMovies() {
    _box.removeAll();
  }

  List<MovieDao> getAllMovies() {
    final query = (_box.query()..order(MovieDao_.orderNumber)).build();
    final movies = query.find();
    query.close();
    return movies;
  }

  List<MovieDao> getMoviesWithIds(List<int> ids) {
    final query = (_box.query(MovieDao_.id.oneOf(ids))..order(MovieDao_.orderNumber)).build();
    final movies = query.find();
    query.close();
    return movies;
  }

  int getMaxOrderNumber() {
    final query = _box.query().build();
    final maxOrderNumber = query.property<int>(MovieDao_.orderNumber).max();
    query.close();
    return maxOrderNumber;
  }
}
