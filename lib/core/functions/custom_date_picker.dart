import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/app_color.dart';

Future<DateTime?> openDatePickerDialog() async {
  DateTime? newDate = await showDatePicker(
    context: Get.context!,
    initialDate: DateTime.now(),
    firstDate: DateTime(2010),
    lastDate: DateTime(2100),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primaryColor, // header background color
            onPrimary: Colors.white, // header text color
            onSurface: Colors.black, // body text color
          ),
          textButtonTheme: TextButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // Button color
              foregroundColor: AppColors.primaryColor, // Text color
            ),
          ),
        ),
        child: child!,
      );
    },
  );

  return newDate;
}