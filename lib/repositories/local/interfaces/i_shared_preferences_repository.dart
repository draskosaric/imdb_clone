abstract class ISharedPreferencesRepository {
  Future<void> setLastGenreFetch(DateTime date);
  Future<DateTime> getLastGenreFetch();
  Future<void> setLastMovieFetch(DateTime date);
  Future<DateTime> getLastMovieFetch();
  Future<void> setLastPageFetched(int page);
  Future<int> getLastPageFetched();
}
