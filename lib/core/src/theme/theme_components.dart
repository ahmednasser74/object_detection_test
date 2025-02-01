part of './theme.dart';

mixin AppThemeComponents {
  CheckboxThemeData get checkBoxTheme => CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor; // Color when the checkbox is selected
          }
          return Colors.transparent; // Color when the checkbox is not selected
        }),
        checkColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          return Colors.white; // Color of the check icon
        }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.r), // Border radius of the checkbox
        ),
        side: const BorderSide(color: Colors.black, strokeAlign: 1),
      );

  RadioThemeData get radioTheme => RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.red; // Color when the checkbox is selected
          }
          return Colors.black; // Color when the checkbox is not selected
        }),
      );

  InputDecorationTheme get inputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      labelStyle: TextStyle(
        fontFamily: AppThemes.fonFamily,
        color: AppColors.greyColor,
        height: 2,
        fontSize: 12.sp,
      ),
      hintStyle: TextStyle(
        fontFamily: AppThemes.fonFamily,
        color: AppColors.greyColor,
        height: 1.4,
        fontSize: 12.sp,
      ),
      errorStyle: TextStyle(fontSize: 10.sp),
      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      errorMaxLines: 1,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.primaryColor.withOpacity(.4),
          width: 1.0,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(14.r)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(14.r)),
      ),
      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6.r)),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
    );
  }

  TextButtonThemeData get buttonTheme {
    return TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all(
          TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 16.sp,
          ),
        ),
        // overlayColor: MaterialStateProperty.all(
        //   Colors.transparent,
        // ),
        // foregroundColor: MaterialStateProperty.all(
        //   Colors.green,
        // ),
        //
        // backgroundColor: MaterialStateProperty.all(
        //   Colors.red,
        // ),
      ),
    );
  }
}
