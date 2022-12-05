import 'package:imdb_clone/repositories/remote/dto/genre_dto.dart';

abstract class IRemoteGenresRepository {
  Future<List<GenreDto>> fetchGenres();
}
