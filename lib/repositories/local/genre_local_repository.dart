import 'package:imdb_clone/objectbox.g.dart';
import 'package:imdb_clone/repositories/local/dao/genre_dao.dart';
import 'package:imdb_clone/repositories/local/interfaces/i_genre_local_repository.dart';
import 'package:objectbox/objectbox.dart';

class GenreLocalRepository implements IGenreLocalRepository {
  final Store store;
  late final Box<GenreDao> _box;

  GenreLocalRepository({required this.store}) {
    _box = store.box<GenreDao>();
  }

  @override
  Future<void> addGenres(List<GenreDao> genres) async => store.runInTransaction(TxMode.write, () {
        _box.removeAll();
        _box.putMany(genres);
      });

  @override
  Future<List<GenreDao>> getByIds(List<int> ids) async {
    final query = (_box.query(GenreDao_.id.oneOf(ids))..order(GenreDao_.name)).build();
    final genres = query.find();
    query.close();
    return Future.value(genres);
  }
}
