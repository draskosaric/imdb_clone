import 'package:flutter/material.dart';
import 'package:imdb_clone/common/colors.dart';
import 'package:imdb_clone/common/themes.dart';

class RatingWidget extends StatelessWidget {
  final double rate;

  const RatingWidget({
    required this.rate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.star,
          color: AppColors.yellowColor,
          size: 18,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          "$rate / 10 IMDb",
          style: rateTextStyle(context),
        )
      ],
    );
  }
}
