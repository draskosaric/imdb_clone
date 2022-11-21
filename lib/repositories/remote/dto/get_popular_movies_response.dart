import 'package:imdb_clone/repositories/remote/dto/movie_simple_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_popular_movies_response.g.dart';

@JsonSerializable()
class GetPopularMoviesResponse {
  @JsonKey(name: "page")
  final int page;
  @JsonKey(name: "results")
  final List<MovieSimpleDto> movies;
  @JsonKey(name: "total_pages")
  final int totalPages;
  @JsonKey(name: "total_results")
  final int totalResults;

  GetPopularMoviesResponse({
    required this.page,
    required this.movies,
    required this.totalPages,
    required this.totalResults,
  });

  factory GetPopularMoviesResponse.fromJson(Map<String, dynamic> json) => _$GetPopularMoviesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetPopularMoviesResponseToJson(this);
}
