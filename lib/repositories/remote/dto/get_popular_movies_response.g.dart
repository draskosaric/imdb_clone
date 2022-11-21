// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_popular_movies_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPopularMoviesResponse _$GetPopularMoviesResponseFromJson(
        Map<String, dynamic> json) =>
    GetPopularMoviesResponse(
      page: json['page'] as int,
      movies: (json['results'] as List<dynamic>)
          .map((e) => MovieSimpleDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );

Map<String, dynamic> _$GetPopularMoviesResponseToJson(
        GetPopularMoviesResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.movies,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
