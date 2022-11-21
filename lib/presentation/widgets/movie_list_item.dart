import 'package:flutter/material.dart';
import 'package:imdb_clone/common/themes.dart';
import 'package:imdb_clone/models/movie.dart';
import 'package:imdb_clone/presentation/widgets/cropped_image.dart';
import 'package:imdb_clone/presentation/widgets/favourite_widget.dart';
import 'package:imdb_clone/presentation/widgets/rating.dart';
import 'package:imdb_clone/presentation/widgets/tags.dart';

class MovieListItem extends StatelessWidget {
  final Movie movie;
  final void Function(Movie) onTap;

  const MovieListItem({
    required this.movie,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //behavior: HitTestBehavior.translucent,
      onTap: () => onTap(movie),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Hero(
              tag: "poster${movie.imageUrl}",
              child: CroppedImage(
                url: movie.imageUrl,
                imageHeight: 40,
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: "title${movie.imageUrl}",
                  child: Text(
                    movie.title,
                    style: movieTitleListTextStyle(context),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Hero(
                  tag: "rate${movie.imageUrl}",
                  child: RatingWidget(rate: movie.rate),
                ),
                const SizedBox(
                  height: 16,
                ),
                TagListWidget(
                  tags: movie.genres.map((g) => g.name).toList(),
                  onClick: (_) {},
                ),
              ],
            ),
          ),
          FavouriteWidget(
            movie: movie,
            // onChangeFavorite: (isFavourite) {
            //   onChangeFavourite(
            //     isFavourite,
            //     movie.id,
            //   );
            // },
          ),
        ],
      ),
    );
  }
}
