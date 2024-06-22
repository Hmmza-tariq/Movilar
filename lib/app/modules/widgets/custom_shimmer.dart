import 'package:flutter/material.dart';
import 'package:movilar/app/resources/color_manager.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({super.key, required this.height, required this.width});
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: ColorManager.lightGrey,
        highlightColor: ColorManager.darkGrey,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: ColorManager.lightGrey,
            borderRadius: BorderRadius.circular(10.0),
          ),
          // color: ColorManager.lightGrey,
        ));
  }
}
