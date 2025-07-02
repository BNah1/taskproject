import 'dart:math';
import 'package:flutter/material.dart';

class AppSize{
  static const double paddingMenu = 5;
  static const double paddingDashBoard = 15;
  static const double borderTile = 15;
  static const double textSizeSubBody = 18;
}

class AppTextStyle{
  static TextStyle dashboardTitle = const TextStyle(fontSize: 25,fontWeight: FontWeight.bold);
  static TextStyle dashboardAction = const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue);

  static TextStyle dashboardWelcome = const TextStyle(fontSize: 35,fontWeight: FontWeight.bold);



  static TextStyle textBodyTile({Color color = Colors.black, FontWeight fontWeight = FontWeight.bold, double size = 22}){
   return TextStyle(fontSize: size, fontWeight: fontWeight, color: color);
  }
  static TextStyle textSubBody = const TextStyle(fontSize: 14,color: Colors.grey);

  static TextStyle textHint( color){
    return TextStyle(fontSize: 20,color: color);
  }

  static TextStyle textSubBodyProject(Color color){
    return TextStyle(fontSize: 20,color: color);
  }

  static TextStyle textTitleTask(Color color){
    return TextStyle(fontSize: 18,color: color,fontWeight: FontWeight.bold);
  }
  static TextStyle textBodyTask(Color color){
    return TextStyle(fontSize: 15,color: color);
  }

}

class AppColor{

  static const List<Color> projectColors = [
    Color(0xFFE3F2FD), // Light blue (Blue[50])
    Color(0xFFFFF9C4), // Light yellow (Yellow[100])
    Color(0xFFFFE0B2), // Light orange (Orange[100])
    Color(0xFFFFCDD2), // Light red/pink (Red[100])
    Color(0xFFF8BBD0), // Light pink
    Color(0xFFD1C4E9), // Light purple
    Color(0xFFC8E6C9), // Light green (Green[100])
    Color(0xFFB2EBF2), // Light cyan
    Color(0xFFFFF3E0), // Light creamy orange
    Color(0xFFDCEDC8), // Light lime green
  ];

  static const List<Color> taskColors = [
    Color(0xFF81C784), // Light green
    Color(0xFF64B5F6), // Light blue
    Color(0xFFFFB74D), // Light orange
    Color(0xFFE57373), // Light red
    Color(0xFFBA68C8), // Light purple
    Color(0xFFFF8A65), // Deep orange
    Color(0xFFA1887F), // Brown-gray
  ];

  static Color taskTileBoard = Colors.white;
  static Color projectTileAll = Colors.grey;

}


class ColorPool {
  final List<Color> _allColors;
  final List<Color> _availableColors = [];

  final Random _random = Random();

  ColorPool(this._allColors) {
    _availableColors.addAll(_allColors);
  }

  Color getNext() {
    if (_availableColors.isEmpty) {
      // Reset lại nếu đã dùng hết
      _availableColors.addAll(_allColors);
    }

    // Lấy ngẫu nhiên và xóa khỏi danh sách
    final index = _random.nextInt(_availableColors.length);
    final color = _availableColors[index];
    _availableColors.removeAt(index);
    return color;
  }
}

final ColorPool colorPool = ColorPool(AppColor.projectColors);
