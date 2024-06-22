import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movilar/app/data/movie.dart';
import 'package:movilar/app/modules/widgets/custom_image.dart';
import 'package:movilar/app/modules/widgets/icon_text_widget.dart';
import 'package:movilar/app/resources/assets_manager.dart';
import 'package:movilar/app/resources/color_manager.dart';
import 'package:movilar/app/routes/app_pages.dart';

class MovieDetailItem extends StatelessWidget {
  const MovieDetailItem({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.MOVIE_DETAIL, arguments: movie);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: CustomImage(
                image: movie.image,
                width: 95,
                height: 120,
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: Get.width - 150,
                    child: Text(
                      movie.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                  // const SizedBox(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconTextWidget(
                        icon: AssetsManager.star,
                        text: movie.ratings,
                        color: ColorManager.orange,
                      ),
                      IconTextWidget(
                        icon: AssetsManager.ticket,
                        text: movie.genre,
                        color: ColorManager.white,
                      ),
                      IconTextWidget(
                        icon: AssetsManager.calendar,
                        text: movie.year,
                        color: ColorManager.white,
                      ),
                      IconTextWidget(
                        icon: AssetsManager.clock,
                        text: movie.duration,
                        color: ColorManager.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
