import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:imdb_clone/common/exceptions.dart';
import 'package:imdb_clone/repositories/remote/dto/get_genres_response.dart';

import 'dto/genre_dto.dart';

class RemoteGenresRepository {
  //final String baseURL;
  final Dio api;

  const RemoteGenresRepository({required this.api});

  Future<List<GenreDto>> fetchGenres() async {
    try {
      const url = "genre/movie/list";
      final response = await api.get(url);
      return GetGenresResponse.fromJson(response.data).genres;
      //return (response.data as List).map((x) => GenreDto.fromJson(x)).toList();
    } on DioError catch (e) {
      debugPrint(e.message);
      throw e.localException;
    } catch (e) {
      debugPrint(e.toString());
      throw ImdbCloneException(type: ImdbCloneExceptionType.other);
    }
  }
}
