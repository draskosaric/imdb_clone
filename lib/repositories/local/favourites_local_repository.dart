import 'package:imdb_clone/objectbox.g.dart';
import 'package:imdb_clone/repositories/local/dao/favourites.dart';
import 'package:objectbox/objectbox.dart';

class FavouritesLocalRepository {
  final Store store;
  late final Box<FavouritesDao> _box;

  FavouritesLocalRepository({required this.store}) {
    _box = store.box<FavouritesDao>();
  }

  Future<void> addFavourite(int favouriteId) async => _box.putAsync(FavouritesDao(id: favouriteId));

  Future<void> removeFavourite(int id) async => _box.remove(id);

  // returns true if added, false if removed
  Future<bool> addOrRemoveFavourite(int id) async {
    final favouriteIds = getFavouriteMovieIds();
    if (favouriteIds.contains(id)) {
      removeFavourite(id);
      return false;
    }
    addFavourite(id);
    return true;
  }

  Future<bool> isMovieFavourite(int id) async {
    final query = _box.query(FavouritesDao_.id.equals(id)).build();
    bool isFavourite = query.find().isNotEmpty;
    query.close();
    return isFavourite;
  }

  List<int> getFavouriteMovieIds() {
    final query = _box.query().build();
    PropertyQuery<int> pq = query.property(FavouritesDao_.id);
    final ids = pq.find();
    query.close();
    return ids;
  }

  Stream<bool> getUpdatesForMovieFavourite(int movieId) {
    final query = _box.query(FavouritesDao_.id.equals(movieId)).watch(triggerImmediately: true);
    return query.map((q) => q.find()).map((e) {
      return e.isNotEmpty;
    });
  }

  Stream<List<int>> getUpdatesForFavourite() {
    final query = _box.query().watch(triggerImmediately: true);
    return query.map<List<FavouritesDao>>((q) => q.find()).map<List<int>>((e) => e.map((el) => el.id).toList());
  }
}
