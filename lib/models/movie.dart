import 'genre.dart';

class Movie {
  final int id;
  final String title;
  final double rate;
  bool isFavourite;
  final List<Genre> genres;
  final String description;
  final String imageUrl;
  final String hugeImageUrl;
  final int orderNumber;

  Movie({
    required this.id,
    required this.title,
    required this.rate,
    required this.isFavourite,
    required this.genres,
    required this.description,
    required this.imageUrl,
    required this.hugeImageUrl,
    required this.orderNumber,
  });

  @override
  String toString() => "$orderNumber. [$title ($id)]\n";
}
