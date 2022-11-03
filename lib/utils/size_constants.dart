import 'package:flutter/material.dart';

class Dimensions {
  static void init({required BuildContext context}) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    safeAreaHorizontal =
        mediaQueryData.padding.left + mediaQueryData.padding.right;
    safeAreaVertical =
        mediaQueryData.padding.top + mediaQueryData.padding.bottom;
    sliderHeight = screenHeight / 6;
  }

  //declare variables here
  static late MediaQueryData mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double safeAreaHorizontal;
  static late double safeAreaVertical;
  static late double sliderHeight;
  static late double addToCartButtonHeight;
}
