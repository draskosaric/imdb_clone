import 'package:imdb_clone/objectbox.g.dart';
import 'package:imdb_clone/repositories/local/dao/favourites.dart';
import 'package:imdb_clone/repositories/local/interfaces/i_favourites_local_repository.dart';
import 'package:objectbox/objectbox.dart';

class FavouritesLocalRepository implements IFavouritesLocalRepository {
  final Store store;
  late final Box<FavouritesDao> _box;

  FavouritesLocalRepository({required this.store}) {
    _box = store.box<FavouritesDao>();
  }

  Future<void> _addFavourite(int favouriteId) async => _box.putAsync(FavouritesDao(id: favouriteId));

  Future<void> _removeFavourite(int id) async => _box.remove(id);

  List<int> _getFavouriteMovieIds() {
    final query = _box.query().build();
    PropertyQuery<int> pq = query.property(FavouritesDao_.id);
    final ids = pq.find();
    query.close();
    return ids;
  }

  // returns true if added, false if removed
  @override
  Future<bool> addOrRemoveFavourite(int id) async {
    final favouriteIds = _getFavouriteMovieIds();
    if (favouriteIds.contains(id)) {
      _removeFavourite(id);
      return false;
    }
    await _addFavourite(id);
    return true;
  }

  @override
  Future<bool> isMovieFavourite(int id) async {
    final query = _box.query(FavouritesDao_.id.equals(id)).build();
    bool isFavourite = query.find().isNotEmpty;
    query.close();
    return isFavourite;
  }

  @override
  Stream<bool> getUpdatesForMovieFavourite(int movieId) {
    final query = _box.query(FavouritesDao_.id.equals(movieId)).watch(triggerImmediately: true);
    return query.map((q) => q.find()).map((e) {
      return e.isNotEmpty;
    });
  }

  @override
  Stream<List<int>> getUpdatesForFavourite() {
    final query = _box.query().watch(triggerImmediately: true);
    return query.map<List<FavouritesDao>>((q) => q.find()).map<List<int>>((e) => e.map((el) => el.id).toList());
  }
}
