import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movilar/app/data/movie.dart';
import 'package:movilar/app/modules/widgets/custom_image.dart';
import 'package:movilar/app/resources/color_manager.dart';
import 'package:movilar/app/routes/app_pages.dart';

class MovieCategoryView extends StatelessWidget {
  final String category;
  final List<Movie> movies;
  const MovieCategoryView(
      {required this.category, super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.builder(
          itemCount: movies.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: .8, crossAxisCount: 3),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.toNamed(Routes.MOVIE_DETAIL, arguments: movies[index]);
              },
              child: Container(
                margin: const EdgeInsets.all(
                  8,
                ),
                decoration: BoxDecoration(
                  color: ColorManager.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CustomImage(
                    image: movies[index].image,
                    width: 140,
                    height: 210,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
