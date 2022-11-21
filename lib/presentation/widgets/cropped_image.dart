import 'package:flutter/material.dart';
import 'package:imdb_clone/presentation/screens/square_network_image.dart';

class CroppedImage extends StatelessWidget {
  final String url;
  final double imageHeight;

  const CroppedImage({
    required this.url,
    required this.imageHeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: SquareNetworkImage(url: url),
      );
}
