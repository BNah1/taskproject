
import 'package:flutter/material.dart';

class AppSize{
  static const double paddingMenu = 5;
  static const double paddingDashBoard = 15;
  static const double borderTile = 15;
}

class AppTextStyle{
  static TextStyle dashboardTitle = const TextStyle(fontSize: 25,fontWeight: FontWeight.bold);
  static TextStyle dashboardAction = const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue);

  static TextStyle dashboardWelcome = const TextStyle(fontSize: 35,fontWeight: FontWeight.bold);



  static TextStyle textBodyTile = const TextStyle(fontSize: 22);
  static TextStyle textSubBody = const TextStyle(fontSize: 14,color: Colors.grey);
  static TextStyle textHint( color){
    return TextStyle(fontSize: 20,color: color);
  }

  static TextStyle textSubBodyProject(Color color){
    return TextStyle(fontSize: 20,color: color);
  }


}