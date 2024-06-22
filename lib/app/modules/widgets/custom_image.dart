import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movilar/app/modules/widgets/custom_shimmer.dart';
import 'package:movilar/app/resources/assets_manager.dart';
import 'package:movilar/app/resources/color_manager.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.image,
    required this.width,
    required this.height,
  });

  final String image;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: image,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorWidget: (context, error, stackTrace) {
          return Image.asset(
            AssetsManager.logo,
            width: width,
            height: height,
            color: ColorManager.lightGrey,
          );
        },
        progressIndicatorBuilder: (context, child, loadingProgress) => SizedBox(
              width: width,
              height: height,
              child: CustomShimmer(
                width: width,
                height: height,
              ),
            ));
  }
}
