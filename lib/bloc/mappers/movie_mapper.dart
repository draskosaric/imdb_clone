import 'package:imdb_clone/models/genre.dart';
import 'package:imdb_clone/models/movie.dart';
import 'package:imdb_clone/repositories/local/dao/genre_dao.dart';
import 'package:imdb_clone/repositories/local/dao/movie_dao.dart';
import 'package:imdb_clone/repositories/local/interfaces/i_genre_local_repository.dart';
import 'package:imdb_clone/repositories/remote/dto/genre_dto.dart';
import 'package:imdb_clone/repositories/remote/dto/movie_simple_dto.dart';

Movie mapMovie(
  MovieDao movie,
  String basePathImage,
  String basePathHugeImage,
) =>
    Movie(
      id: movie.id,
      title: movie.title,
      rate: movie.averageVote,
      isFavourite: false,
      genres: movie.genres.map((genre) => mapGenre(genre)).toList(),
      description: movie.description,
      imageUrl: "$basePathImage${movie.posterPath}",
      hugeImageUrl: "$basePathHugeImage${movie.posterPath}",
      orderNumber: movie.orderNumber,
    );

Genre mapGenre(GenreDao genre) => Genre(
      id: genre.id,
      name: genre.name,
    );

GenreDao mapGenreDto(GenreDto genreDto) => GenreDao(
      id: genreDto.id,
      name: genreDto.name,
    );

Future<MovieDao> mapByMovieDto(MovieSimpleDto mDto, int orderNumber, IGenreLocalRepository genreLocalRepository) async {
  final movie = MovieDao(
      id: mDto.id,
      title: mDto.title,
      averageVote: mDto.voteAverage,
      description: mDto.overview,
      posterPath: mDto.posterPath,
      orderNumber: orderNumber++);
  final genres = await genreLocalRepository.getByIds(mDto.genreIds);
  movie.genres.addAll(genres);
  return movie;
}
