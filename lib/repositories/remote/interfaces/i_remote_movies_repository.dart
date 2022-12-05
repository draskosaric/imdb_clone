import 'package:imdb_clone/repositories/remote/dto/movie_simple_dto.dart';

abstract class IRemoteMoviesRepository {
  Future<List<MovieSimpleDto>> fetchMovies({int page = 1, String language = "en_US"});
}
