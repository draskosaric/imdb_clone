import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imdb_clone/common/colors.dart';

class SquareNetworkImage extends StatelessWidget {
  final String url;
  final bool showPlaceholder;

  const SquareNetworkImage({
    required this.url,
    this.showPlaceholder = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 1,
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          alignment: FractionalOffset.center,
          imageUrl: url,
          errorWidget: (context, url, error) => Container(
            height: MediaQuery.of(context).size.height,
            color: AppColors.chipDefaultColor,
            child: Icon(
              Icons.error_rounded,
              color: AppColors.qDefaultColor,
              size: 40.0,
            ),
          ),
        ),
      );
}
