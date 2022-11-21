import 'package:flutter/material.dart';
import 'package:imdb_clone/common/colors.dart';

class ErrorDefaultPage extends StatelessWidget {
  final FlutterErrorDetails details;
  final bool inDebug;

  const ErrorDefaultPage({
    required this.details,
    this.inDebug = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (inDebug) return ErrorWidget(details.exception);
    return Material(
      color: AppColors.defaultBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.error, color: AppColors.qDefaultColor),
            const SizedBox(
              height: 16,
            ),
            Text("There was an error (${details.exception.toString()}"),
          ],
        ),
      ),
    );
  }
}
