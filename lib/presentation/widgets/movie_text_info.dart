import 'package:flutter/material.dart';
import 'package:imdb_clone/common/themes.dart';
import 'package:imdb_clone/models/movie.dart';
import 'package:imdb_clone/presentation/widgets/favourite_widget.dart';
import 'package:imdb_clone/presentation/widgets/rating.dart';
import 'package:imdb_clone/presentation/widgets/tags.dart';

class MovieTextInfo extends StatelessWidget {
  final Movie movie;

  const MovieTextInfo({
    required this.movie,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                movie.title,
                style: movieTitleTextStyle(context),
              ),
            ),
            FavouriteWidget(
              movie: movie,
            ),
          ],
        ),
        const SizedBox(
          height: 8.0,
        ),
        RatingWidget(rate: movie.rate),
        const SizedBox(
          height: 8.0,
        ),
        TagListWidget(
          tags: movie.genres.map((g) => g.name).toList(),
          onClick: (_) {},
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          "Description",
          style: descriptionTitleStyle(context),
        ),
        const SizedBox(
          height: 8,
        ),
        Expanded(
          child: Text(
            movie.description,
            style: descriptionTextStyle(context),
          ),
        ),
      ],
    );
  }
}
