abstract class IFavouritesLocalRepository {
  Future<bool> addOrRemoveFavourite(int id);
  Future<bool> isMovieFavourite(int id);
  Stream<bool> getUpdatesForMovieFavourite(int movieId);
  Stream<List<int>> getUpdatesForFavourite();
}
