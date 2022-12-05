import 'package:imdb_clone/repositories/local/dao/genre_dao.dart';

abstract class IGenreLocalRepository {
  Future<void> addGenres(List<GenreDao> genres);
  Future<List<GenreDao>> getByIds(List<int> ids);
}
