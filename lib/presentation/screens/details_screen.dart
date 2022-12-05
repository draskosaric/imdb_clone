import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_clone/common/colors.dart';
import 'package:imdb_clone/common/const.dart';
import 'package:imdb_clone/models/movie.dart';
import 'package:imdb_clone/presentation/screens/square_network_image.dart';
import 'package:imdb_clone/presentation/widgets/movie_text_info.dart';

class DetailsScreen extends StatelessWidget {
  final Movie movie;

  static const double radius = 25.0;

  const DetailsScreen({
    required this.movie,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: "poster${movie.imageUrl}",
            child: SquareNetworkImage(
              url: movie.hugeImageUrl,
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(top: 16.0 + radius, left: 16.0, right: 16.0),
              width: double.infinity,
              height: 2 * MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                color: AppColors.defaultBackgroundColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(radius),
                ),
              ),
              child: MovieTextInfo(
                movie: movie,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Container(
              height: 66,
              padding: const EdgeInsets.only(left: 16, top: 28, right: 16, bottom: 20),
              child: SvgPicture.asset(
                backImagePath,
                color: AppColors.defaultTextColor,
                height: 10,
                width: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
