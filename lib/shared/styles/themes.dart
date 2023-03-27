import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/shared/styles/colors.dart';

ThemeData darkTheme=ThemeData(
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: DarkMode.secondaryColor,
    ),
  ),
  primarySwatch: DarkMode.swatchColor as MaterialColor,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    unselectedItemColor: DarkMode.secondaryColor,
    backgroundColor: DarkMode.primaryColor,
    elevation: 20.0,
    selectedItemColor: DarkMode.swatchColor,
    type: BottomNavigationBarType.fixed,
  ),
  scaffoldBackgroundColor: DarkMode.primaryColor,
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    iconTheme: IconThemeData(
      color: DarkMode.secondaryColor,
    ),
    titleTextStyle: TextStyle(
      color: DarkMode.secondaryColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    elevation: 0.0,
    backgroundColor: DarkMode.primaryColor,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: DarkMode.secondaryColor,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
);


ThemeData lightTheme=ThemeData(
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: LightMode.secondaryColor,
    ),
  ),
  primarySwatch: LightMode.swatchColor as MaterialColor,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 20.0,
    selectedItemColor: LightMode.swatchColor,
    type: BottomNavigationBarType.fixed,
  ),
  scaffoldBackgroundColor: LightMode.primaryColor,
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    iconTheme: IconThemeData(
      color: LightMode.secondaryColor,
    ),
    titleTextStyle: TextStyle(
      color: LightMode.secondaryColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: LightMode.primaryColor,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: LightMode.primaryColor,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
);