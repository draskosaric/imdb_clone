import 'package:imdb_clone/repositories/remote/dto/genre_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_genres_response.g.dart';

@JsonSerializable()
class GetGenresResponse {
  final List<GenreDto> genres;

  GetGenresResponse({required this.genres});

  factory GetGenresResponse.fromJson(Map<String, dynamic> json) => _$GetGenresResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetGenresResponseToJson(this);
}
