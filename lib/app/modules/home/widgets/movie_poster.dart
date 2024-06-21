import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movilar/app/data/movie.dart';
import 'package:movilar/app/resources/color_manager.dart';
import 'package:movilar/app/routes/app_pages.dart';

class MoviePoster extends StatelessWidget {
  final Movie movie;
  final int index;

  const MoviePoster({required this.movie, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Get.toNamed(Routes.MOVIE_DETAIL, arguments: movie);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 6.0, left: 12, bottom: 24.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                movie.image,
                width: 140,
                height: 210,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: 50,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Stack(
                children: [
                  Text(
                    (index + 1).toString(),
                    style: TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = ColorManager.blue,
                    ),
                  ),
                  Text(
                    (index + 1).toString(),
                    style: const TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
