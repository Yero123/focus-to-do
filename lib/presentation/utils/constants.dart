import 'package:flutter/material.dart';

class AppColors {
  // Define tus colores como constantes estáticas
  static const Color primaryColor = Color(0xFFE55E62);
  static const Color primaryColorIncomplete =
      Color.fromARGB(255, 255, 179, 182);

  static const Color secondaryColor = Color(0xFFFFE6E4);
  static const Color textColor = Colors.black;
  static const Color backgroundColor = Color(0xFFF7F7F9);
  static const Color white = Colors.white;
  static const Color greenIcon = Color(0xFF489F58);
  static const Color orangeIcon = Color(0xFFE4864F);
  static const Color purpleIcon = Color(0xFF6D54CC);
  static const Color greenBlueIcon = Color(0xFF0AAF8D);
  static const Color gray = Color(0xFF90929F);
  static const Color grayLight = Color(0xFFEFEFEF);

  static const Color blueLightIcon = Color(0xFF118BE1);
  static const Color black = Color(0xFF1E1E1E);
  //Priority colors
  // static const Color highPriorityColor = Color(0xFFE55E62);
  static const Color highPriorityColor = Color(0xFFF53B2E);
  static const Color highPriorityColorLight = Color(0xFFFFF5F4);

  // static const Color mediumPriorityColor = Color(0xFFD8AF45);
  static const Color mediumPriorityColor = Color(0xFFFDB102);
  static const Color mediumPriorityColorLight = Color(0xFFFFFDF1);

  // static const Color lowPriorityColor = Color(0xFF45D865);
  static const Color lowPriorityColor = Color(0xFF53CD06);
  static const Color lowPriorityColorLight = Color(0xFFF1FFF5);

  static const Color nonePriorityColor = Color(0xFFA9A9A9);
  static const Color nonePriorityColorLight = Color(0xFFFAFAFA);

  static const List<Color> colorPicker = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
  ];
  // Agrega más colores según sea necesario
  // Constructor privado para evitar instanciación
  AppColors._();
}

class AppTextStyles {
  // Define tus colores como constantes estáticas

  static const TextStyle primaryColor =
      TextStyle(fontSize: 24, color: Colors.black);
  static const TextStyle primaryColor2 =
      TextStyle(fontSize: 24, color: Colors.black);
}

enum TaskPriority { low, medium, high, none }

Map priorityColors = {
  TaskPriority.low: AppColors.lowPriorityColor,
  TaskPriority.medium: AppColors.mediumPriorityColor,
  TaskPriority.high: AppColors.highPriorityColor,
  TaskPriority.none: AppColors.nonePriorityColor,
};

enum TaskTime { today, tomorrow, sevenDays, someday }

Map timeColors = {
  TaskTime.today: AppColors.greenIcon,
  TaskTime.tomorrow: AppColors.orangeIcon,
  TaskTime.sevenDays: AppColors.greenBlueIcon,
  TaskTime.someday: AppColors.purpleIcon,
};

Map timeIcons = {
  TaskTime.today: Icons.sunny,
  TaskTime.tomorrow: Icons.offline_bolt,
  TaskTime.sevenDays: Icons.calendar_today,
  TaskTime.someday: Icons.calendar_month,
};

Map timeNames = {
  TaskTime.today: "Hoy",
  TaskTime.tomorrow: "Mañana",
  TaskTime.sevenDays: "En 7 dias",
  TaskTime.someday: "Algun día",
};
