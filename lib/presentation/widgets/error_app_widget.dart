import 'package:flutter/material.dart';
import 'package:imdb_clone/common/colors.dart';

class ErrorAppWidget extends StatelessWidget {
  const ErrorAppWidget({super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: Icon(
          Icons.error,
          size: 40,
          color: AppColors.qDefaultColor,
        ),
      );
}
