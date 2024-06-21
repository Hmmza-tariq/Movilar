import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    scaffoldBackgroundColor: ColorManager.primary,
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightGrey,
    primaryColorDark: ColorManager.darkGrey,
    disabledColor: ColorManager.lightestGrey,
    splashColor: ColorManager.transparent,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: ColorManager.primary,
      secondary: ColorManager.blue,
    ),
    dividerColor: Colors.transparent,

    // Card Theme
    cardTheme: const CardTheme(
      color: ColorManager.darkGrey,
      shadowColor: ColorManager.lightGrey,
      elevation: AppSize.s4,
    ),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.primary,
      centerTitle: true,
      elevation: 0,
      shadowColor: ColorManager.lightGrey,
      iconTheme: const IconThemeData(
        color: ColorManager.white,
      ),
      titleTextStyle: getRegularStyle(
        color: ColorManager.white,
        fontSize: AppSize.s16,
      ),
    ),

    // Button Theme
    buttonTheme: const ButtonThemeData(
      buttonColor: ColorManager.blue,
      splashColor: ColorManager.lightGrey,
      shape: StadiumBorder(),
      disabledColor: ColorManager.lightestGrey,
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: ColorManager.white,
        backgroundColor: ColorManager.blue,
        textStyle: getRegularStyle(
          color: ColorManager.white,
          fontSize: FontSize.s16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
      ),
    ),

    // Text Theme
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      displayLarge: getSemiBoldStyle(
        color: ColorManager.white,
        fontSize: FontSize.s16,
      ),
      titleMedium: getMediumStyle(
        color: ColorManager.lightestGrey,
        fontSize: FontSize.s14,
      ),
      bodySmall: getRegularStyle(color: ColorManager.lightestGrey),
      bodyLarge: getRegularStyle(color: ColorManager.lightGrey),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p16),
      hintStyle: getRegularStyle(color: ColorManager.lightGrey),
      labelStyle: getMediumStyle(color: ColorManager.lightGrey),
      errorStyle: getRegularStyle(color: ColorManager.red),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
        borderSide: BorderSide(
          color: ColorManager.transparent,
          width: AppSize.s1_5,
        ),
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
        borderSide: BorderSide(
          color: ColorManager.transparent,
          width: AppSize.s1_5,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
        borderSide: BorderSide(
          color: ColorManager.transparent,
          width: AppSize.s1_5,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
        borderSide: BorderSide(
          color: ColorManager.transparent,
          width: AppSize.s1_5,
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
        borderSide: BorderSide(
          color: ColorManager.transparent,
          width: AppSize.s1_5,
        ),
      ),
    ),

    // Dialog Theme
    dialogTheme: const DialogTheme(
      backgroundColor: ColorManager.darkGrey,
    ),

    // Expansion Tile Theme
    expansionTileTheme: const ExpansionTileThemeData(
      collapsedBackgroundColor: ColorManager.darkGrey,
    ),
  );
}
