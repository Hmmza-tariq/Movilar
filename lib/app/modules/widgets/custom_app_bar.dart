import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movilar/app/modules/home/controllers/home_controller.dart';
import 'package:movilar/app/resources/color_manager.dart';

AppBar customAppBar(String text,
    {double? appBarHeight,
    Function? onPressedBack,
    void Function()? onPressedIcon,
    IconData? icon}) {
  HomeController controller = Get.find<HomeController>();
  return AppBar(
    elevation: 0,
    title: Text(text,
        style: const TextStyle(
            fontFamily: 'Montserrat',
            color: ColorManager.white,
            fontSize: 16,
            fontWeight: FontWeight.w600)),
    centerTitle: true,
    backgroundColor: ColorManager.primary,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios_rounded, color: ColorManager.white),
      onPressed: () {
        if (onPressedBack != null) {
          onPressedBack();
        } else {
          controller.changeTabIndex(0);
        }
      },
    ),
    toolbarHeight: appBarHeight ?? 100,
    actions: [
      icon != null
          ? Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: Icon(icon, color: ColorManager.white),
                onPressed: onPressedIcon,
              ),
            )
          : const SizedBox(),
    ],
  );
}
