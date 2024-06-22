import 'package:flutter/material.dart';
import 'package:movilar/app/resources/color_manager.dart';

Widget noInternetDialog(void Function()? onPressed) {
  return AlertDialog(
    icon: const Icon(Icons.wifi_off_rounded, color: ColorManager.red),
    title: const Text('No Internet',
        style:
            TextStyle(color: ColorManager.white, fontWeight: FontWeight.bold)),
    content: const Text('Please check your internet connection',
        style: TextStyle(color: ColorManager.white)),
    actions: [
      TextButton(
        onPressed: onPressed,
        child: const Text('OK', style: TextStyle(color: ColorManager.white)),
      )
    ],
  );
}
