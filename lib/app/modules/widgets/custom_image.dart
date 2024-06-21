import 'package:flutter/material.dart';
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
    return Image.network(image,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error);
        },
        loadingBuilder: (context, child, loadingProgress) =>
            loadingProgress == null
                ? child
                : SizedBox(
                    width: width,
                    height: height,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.white,
                      ),
                    ),
                  ));
  }
}
