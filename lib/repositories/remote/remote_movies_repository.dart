import 'package:dio/dio.dart';
import 'package:imdb_clone/common/exceptions.dart';
import 'package:imdb_clone/repositories/remote/dto/get_popular_movies_response.dart';
import 'package:imdb_clone/repositories/remote/dto/movie_simple_dto.dart';
import 'package:imdb_clone/repositories/remote/interfaces/i_remote_movies_repository.dart';

class RemoteMoviesRepository extends IRemoteMoviesRepository {
  final Dio api;

  RemoteMoviesRepository({required this.api});

  @override
  Future<List<MovieSimpleDto>> fetchMovies({int page = 1, String language = "en_US"}) async {
    try {
      const url = "movie/popular";
      final response = await api.get(url, queryParameters: {'page': page, 'language': language});

      return GetPopularMoviesResponse.fromJson(response.data).movies;
    } on DioError catch (e) {
      throw e.localException;
    }
  }
}
