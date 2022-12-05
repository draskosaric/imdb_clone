import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:imdb_clone/common/exceptions.dart';
import 'package:imdb_clone/repositories/remote/dto/get_genres_response.dart';
import 'package:imdb_clone/repositories/remote/interfaces/i_remote_genres_repository.dart';

import 'dto/genre_dto.dart';

class RemoteGenresRepository extends IRemoteGenresRepository {
  //final String baseURL;
  final Dio api;

  RemoteGenresRepository({required this.api});

  @override
  Future<List<GenreDto>> fetchGenres() async {
    try {
      const url = "genre/movie/list";
      final response = await api.get(url);
      return GetGenresResponse.fromJson(response.data).genres;
    } on DioError catch (e) {
      debugPrint(e.message);
      throw e.localException;
    } catch (e) {
      debugPrint(e.toString());
      throw ImdbCloneException(type: ImdbCloneExceptionType.other);
    }
  }
}
