import 'package:flutter/material.dart';
import 'package:imdb_clone/common/colors.dart';

ThemeData appTheme = _appTheme();
TextStyle? titleSectionTextStyle(BuildContext context) => Theme.of(context).textTheme.titleLarge;
TextStyle? movieTitleTextStyle(BuildContext context) => Theme.of(context).textTheme.titleMedium;
TextStyle? movieTitleListTextStyle(BuildContext context) => Theme.of(context).textTheme.titleSmall!;
TextStyle? descriptionTitleStyle(BuildContext context) => Theme.of(context).textTheme.titleSmall!;
TextStyle? descriptionTextStyle(BuildContext context) => Theme.of(context).textTheme.bodyMedium!;
TextStyle? rateTextStyle(BuildContext context) => Theme.of(context).textTheme.bodyMedium!;
TextStyle? chipTextStyle(BuildContext context) => Theme.of(context).textTheme.bodyMedium!;
TextStyle? snackBarTextStyle(BuildContext context) => Theme.of(context).textTheme.bodyMedium!;

TextStyle? chipTextListItemStyle(BuildContext context) => Theme.of(context).textTheme.bodySmall!;

ThemeData _appTheme() {
  final ThemeData base = ThemeData.dark();

  return base.copyWith(
    scaffoldBackgroundColor: AppColors.defaultBackgroundColor,
    textTheme: _appTextTheme(base.textTheme),
    colorScheme: base.colorScheme.copyWith(
      primary: AppColors.qDefaultColor,
      secondary: AppColors.qDefaultColor,
    ),
  );
}

TextTheme _appTextTheme(TextTheme base) => base.copyWith(
      titleLarge: base.titleLarge!.copyWith(
        fontSize: 24,
        //height: 30,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: base.titleMedium!.copyWith(
        fontSize: 22,
        // height: 29,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: base.titleSmall!.copyWith(
        fontSize: 15,
        // height: 20,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: base.bodyMedium!.copyWith(
        fontSize: 13,
        // height: 18,
        fontWeight: FontWeight.w300,
      ),
      bodySmall: base.bodySmall!.copyWith(
        fontSize: 12,
        // height: 16,
        fontWeight: FontWeight.w400,
      ),
    );
