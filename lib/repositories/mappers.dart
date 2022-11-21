import 'package:imdb_clone/repositories/local/dao/genre_dao.dart';
import 'package:imdb_clone/repositories/remote/dto/genre_dto.dart';

class GenreMapper {
  GenreDao map(GenreDto genreDto) => GenreDao(
        id: genreDto.id,
        name: genreDto.name,
      );
}
