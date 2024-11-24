import 'package:flutter/material.dart';
part 'app_icons.dart';
part 'color/light_color.dart';
part 'text_styles.dart';
part 'extention.dart';

class AppTheme {
  static final ThemeData appTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColor.primary,
      cardColor: Colors.white,
      unselectedWidgetColor: Colors.grey,
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: AppColor.white),
      appBarTheme: AppBarTheme(
          backgroundColor: Colorpallete.white,
          iconTheme: IconThemeData(
            color: Colorpallete.primary,
          ),
          elevation: 0,
          toolbarTextStyle: const TextTheme(
            headlineSmall: TextStyle(
                color: Colors.black, fontSize: 26, fontStyle: FontStyle.normal),
          ).bodyMedium,
          titleTextStyle: const TextTheme(
            headlineSmall: TextStyle(
                color: Colors.black, fontSize: 26, fontStyle: FontStyle.normal),
          ).titleLarge),
      tabBarTheme: TabBarTheme(
        labelStyle: TextStyles.titleStyle.copyWith(color: Colorpallete.primary),
        unselectedLabelColor: AppColor.darkGrey,
        unselectedLabelStyle:
            TextStyles.titleStyle.copyWith(color: AppColor.darkGrey),
        labelColor: Colorpallete.primary,
        labelPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colorpallete.primary,
      ),
      colorScheme: const ColorScheme(
              onPrimary: Colors.white,
              onError: Colors.white,
              onSecondary: Colors.white,
              onSurface: Colors.black,
              error: Colors.red,
              primary: Colors.amber,
              primaryContainer: Colors.amber,
              secondary: AppColor.secondary,
              secondaryContainer: AppColor.darkGrey,
              surface: Colors.white,
              brightness: Brightness.light)
          .copyWith(surface: Colorpallete.white),
      bottomAppBarTheme: BottomAppBarTheme(color: Colors.white));

  static List<BoxShadow> shadow = <BoxShadow>[
    BoxShadow(
        blurRadius: 10,
        offset: const Offset(5, 5),
        color: AppTheme.appTheme.colorScheme.secondary,
        spreadRadius: 1)
  ];
  static BoxDecoration softDecoration =
      const BoxDecoration(boxShadow: <BoxShadow>[
    BoxShadow(
        blurRadius: 8,
        offset: Offset(5, 5),
        color: Color(0xffe2e5ed),
        spreadRadius: 5),
    BoxShadow(
        blurRadius: 8,
        offset: Offset(-5, -5),
        color: Color(0xffffffff),
        spreadRadius: 5)
  ], color: Color(0xfff1f3f6));
}

String get description {
  return '';
}
