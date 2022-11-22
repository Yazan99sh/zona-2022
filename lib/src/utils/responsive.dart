import 'package:flutter/material.dart';

class Responsive
{
  static getScreenHeightWithoutStatusBar(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return screenHeight - statusBarHeight;
  }

  static getScreenHeightWithoutStatusBarAndAppBar(BuildContext context,AppBar appBar) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double appBarHeight = appBar.preferredSize.height;
    return screenHeight - statusBarHeight - appBarHeight;
  }
  static getScreenHeight(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight;
  }
  static getScreenWidth(BuildContext context)
  {
    final double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth;
  }
}