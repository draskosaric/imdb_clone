import 'package:flutter/material.dart';
import 'package:imdb_clone/common/colors.dart';

class TagListWidget extends StatelessWidget {
  final List<String> tags;
  final void Function(String) onClick;

  const TagListWidget({
    required this.tags,
    required this.onClick,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Wrap(
        direction: Axis.horizontal,
        runSpacing: 8,
        spacing: 8.0,
        children: tags
            .map((tag) => _TagWidget(
                  text: tag,
                  onClick: onClick,
                ))
            .toList(),
      );
}

class _TagWidget extends StatelessWidget {
  final String text;
  final void Function(String) onClick;

  const _TagWidget({
    required this.text,
    required this.onClick,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(text),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          color: AppColors.chipDefaultColor,
        ),
        padding: const EdgeInsets.all(4),
        child: Text(text),
      ),
    );
  }
}
