import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movilar/app/resources/color_manager.dart';
import 'package:flutter/material.dart';

final otpInputDecoration = InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 15),
    border: customOutlineInputBorder(
        borderRadius: 15, borderColor: ColorManager.textColor),
    focusedBorder: customOutlineInputBorder(
        borderRadius: 15, borderColor: ColorManager.textColor),
    enabledBorder: customOutlineInputBorder(
        borderRadius: 15, borderColor: ColorManager.textColor));

final searchFieldInputDecoration = InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 15),
    hintText: "Search for products",
    border: customOutlineInputBorder(
        borderColor: ColorManager.primary, borderRadius: 16, borderWidth: 2),
    focusedBorder: customOutlineInputBorder(
        borderColor: ColorManager.transparent,
        borderRadius: 16,
        borderWidth: 0),
    // hintText: "Search",
    prefixIcon: Container(
      margin: const EdgeInsets.only(left: 20),
      child: const Icon(FontAwesomeIcons.magnifyingGlass),
    ),
    prefixIconConstraints: const BoxConstraints(maxHeight: 45, maxWidth: 45),
    prefixText: "  ");

OutlineInputBorder customOutlineInputBorder(
    {Color? borderColor, double? borderRadius, double borderWidth = 1}) {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius!),
      borderSide: BorderSide(color: borderColor!, width: borderWidth));
}
