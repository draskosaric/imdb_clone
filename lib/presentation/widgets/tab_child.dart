import 'package:flutter/material.dart';

class TabChild extends StatelessWidget {
  final Widget image;
  final String text;

  const TabChild({
    required this.image,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          image,
          const SizedBox(width: 8),
          Text(text),
        ],
      );
}
