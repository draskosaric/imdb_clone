import 'package:imdb_clone/repositories/local/interfaces/i_shared_preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository implements ISharedPreferencesRepository {
  static const String _lastGenreFetch = "LAST_TIME_GENRE_FETCHED";
  static const String _lastMoviesFetch = "LAST_TIME_MOVIES_FETCHED";
  static const String _lastPageFetch = "LAST_PAGE_FETCHED";

  @override
  Future<void> setLastGenreFetch(DateTime date) async =>
      await _saveValueFromKey(_lastGenreFetch, date.millisecondsSinceEpoch);

  @override
  Future<DateTime> getLastGenreFetch() async =>
      DateTime.fromMillisecondsSinceEpoch(await _getValueFromKey(_lastGenreFetch));

  @override
  Future<void> setLastMovieFetch(DateTime date) async =>
      await _saveValueFromKey(_lastMoviesFetch, date.millisecondsSinceEpoch);

  @override
  Future<DateTime> getLastMovieFetch() async =>
      DateTime.fromMillisecondsSinceEpoch(await _getValueFromKey(_lastMoviesFetch));

  @override
  Future<void> setLastPageFetched(int page) async => await _saveValueFromKey(_lastPageFetch, page);

  @override
  Future<int> getLastPageFetched() async => await _getValueFromKey(_lastPageFetch);

  Future<int> _getValueFromKey(String key) async => (await SharedPreferences.getInstance()).getInt(key) ?? 0;
  Future<void> _saveValueFromKey(String key, int value) async =>
      (await SharedPreferences.getInstance()).setInt(key, value);
}
