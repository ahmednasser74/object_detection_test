import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors.dart';

part './theme_components.dart';

class AppThemes with AppThemeComponents {
  AppThemes();
  static const fonFamily = 'din';

  ThemeData get lightThemeData {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(
          AppColors.primaryColor.value,
          const {
            50: AppColors.primaryColor,
            100: AppColors.primaryColor,
            200: AppColors.primaryColor,
            300: AppColors.primaryColor,
            400: AppColors.primaryColor,
            500: AppColors.primaryColor,
            600: AppColors.primaryColor,
            700: AppColors.primaryColor,
            800: AppColors.primaryColor,
            900: AppColors.primaryColor,
          },
        ),
      ).copyWith(
        primary: AppColors.primaryColor,
        secondary: AppColors.primaryLightColor,
      ),
      fontFamily: fonFamily,
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        backgroundColor: Colors.white,
      ),
      dividerTheme: DividerThemeData(space: 1, thickness: .5, color: Colors.grey.shade400),
      dividerColor: Colors.grey.shade400,
      checkboxTheme: checkBoxTheme,
      textTheme: TextTheme(
        headlineSmall: TextStyle(fontSize: 14.sp, fontFamily: fonFamily, color: Colors.teal),
        titleLarge: TextStyle(fontSize: 12.sp, fontFamily: fonFamily, color: Colors.red),
        //* used for AppTextButton
        titleMedium: TextStyle(
          fontSize: 16.sp,
          fontFamily: fonFamily,
          color: AppColors.blackColor,
        ),
        titleSmall: TextStyle(fontSize: 14.sp, fontFamily: fonFamily, color: Colors.purple),
        displayLarge: TextStyle(fontSize: 24.sp, fontFamily: fonFamily, color: Colors.deepPurple),
        displayMedium: TextStyle(fontSize: 22.sp, fontFamily: fonFamily, color: Colors.deepOrange),
        displaySmall: TextStyle(fontSize: 20.sp, fontFamily: fonFamily, color: Colors.grey),
        headlineMedium: TextStyle(fontSize: 18.sp, fontFamily: fonFamily, color: Colors.pink),
        bodyMedium: TextStyle(fontSize: 14.sp, fontFamily: fonFamily, color: Colors.black),
        headlineLarge: TextStyle(fontSize: 24.sp, fontFamily: fonFamily, color: Colors.orange),
        labelMedium: TextStyle(fontSize: 16.sp, fontFamily: fonFamily, color: Colors.green),
        labelLarge: TextStyle(fontSize: 16.sp, fontFamily: fonFamily, color: Colors.black),

        /// list tile color
        // bodyText1: TextStyle(fontSize: 16, fontFamily: fonFamily, color: Colors.white),
        /// default style of text
      ),
      primaryColor: AppColors.primaryColor,
      // accentColor: Theme.of(context).primaryLightColor,
      // backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black, size: 18.sp),
      scaffoldBackgroundColor: AppColors.white,
      unselectedWidgetColor: Colors.black,
      inputDecorationTheme: inputDecorationTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 12,
          fontFamily: fonFamily,
          color: AppColors.blackColor,
        ),
        iconTheme: IconThemeData(color: AppColors.primaryColor, size: 16.sp),
      ),
      radioTheme: radioTheme,
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.red,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      textButtonTheme: buttonTheme,
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStateProperty.all(
            const TextStyle(fontSize: 16, color: Colors.green, fontFamily: fonFamily),
          ),
        ),
      ),
    );
  }
}
