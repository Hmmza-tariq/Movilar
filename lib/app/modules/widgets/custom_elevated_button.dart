import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movilar/app/resources/color_manager.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.bgColor,
      this.fgColor});
  final void Function() onPressed;
  final String text;
  final Color? bgColor;
  final Color? fgColor;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(Get.width * 0.9, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: bgColor ?? ColorManager.white,
              foregroundColor: fgColor ?? ColorManager.black,
              textStyle: const TextStyle(fontSize: 24),
            ),
            onPressed: onPressed,
            child: Center(child: Text(text))),
      ),
    );
  }
}
