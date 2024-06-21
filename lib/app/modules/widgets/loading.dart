import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:movilar/app/resources/color_manager.dart';

Future<dynamic> loadingWidget(String text) {
  return Get.dialog(
    AlertDialog(
      backgroundColor: ColorManager.primary,
      title: Text(text,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontFamily: 'Montserrat',
              color: ColorManager.white,
              fontSize: 16,
              fontWeight: FontWeight.w600)),
      content: const LinearProgressIndicator(
        color: ColorManager.white,
        backgroundColor: ColorManager.darkGrey,
      ),
    ),
  );
}
