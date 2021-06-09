import 'package:flutter/material.dart';
import 'package:lab4/main.dart';

const white = Color(0xFFFFFFFF);
const black = Color(0xFF000000);
const primary = Color(0xFF000000);
var textColor = white;

const appBarColor = Color(0xFF131313);
const appFooterColor = Color(0xFF131313);

const textFieldBackground = Color(0xFF262626);
const buttonFollowColor = Color(0xFF0494F5);
const storyBorderColor = [Color(0xFF9B2282), Color(0xFFEEA863)];

Color getThemeColor() {
  var themeIndex = MyApp.mainSharedPreferences?.getInt("selectedThemeIndex");
  return themeIndex == 0 ? black : white;
}
