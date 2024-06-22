import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movilar/app/modules/widgets/custom_app_bar.dart';
import 'package:movilar/app/modules/widgets/custom_image.dart';
import 'package:movilar/app/modules/widgets/icon_text_widget.dart';
import 'package:movilar/app/modules/widgets/no_internet_dialog.dart';
import 'package:movilar/app/resources/assets_manager.dart';
import 'package:movilar/app/resources/color_manager.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../controllers/movie_detail_controller.dart';

class MovieDetailView extends GetView<MovieDetailController> {
  const MovieDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          appBar: customAppBar("Detail",
              appBarHeight: 70,
              onPressedBack: () {
                Get.back();
              },
              icon: controller.isWatchListed.value == true
                  ? Icons.bookmark
                  : Icons.bookmark_border,
              onPressedIcon: () {
                controller.toggleWatchList();
              }),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 70),
                        child: CustomImage(
                          image: controller.movie.value.banner,
                          width: double.infinity,
                          height: Get.height * .3,
                        ),
                      ),
                      Positioned(
                        bottom: 78,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: ColorManager.darkGrey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(AssetsManager.star,
                                  colorFilter: const ColorFilter.mode(
                                      ColorManager.orange, BlendMode.srcIn),
                                  width: 20),
                              const SizedBox(width: 4),
                              Text(
                                controller.movie.value.ratings.substring(0, 3),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: ColorManager.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CustomImage(
                                image: controller.movie.value.image,
                                width: 100,
                                height: 150,
                              ),
                            ),
                            const SizedBox(width: 16),
                            SizedBox(
                              width: Get.width * .5,
                              child: Text(
                                controller.movie.value.title,
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: ColorManager.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconTextWidget(
                      icon: AssetsManager.ticket,
                      text: controller.movie.value.genre,
                      color: ColorManager.lightGrey,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "|",
                      style: TextStyle(
                        color: ColorManager.lightGrey,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconTextWidget(
                      icon: AssetsManager.calendar,
                      text: controller.movie.value.year,
                      color: ColorManager.lightGrey,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "|",
                      style: TextStyle(
                        color: ColorManager.lightGrey,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconTextWidget(
                      icon: AssetsManager.clock,
                      text: controller.movie.value.duration,
                      color: ColorManager.lightGrey,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      const TabBar(
                        isScrollable: true,
                        dragStartBehavior: DragStartBehavior.start,
                        padding: EdgeInsets.all(0),
                        labelPadding: EdgeInsets.only(right: 30),
                        indicatorWeight: 2,
                        indicatorColor: ColorManager.lightGrey,
                        labelColor: ColorManager.white,
                        dividerColor: ColorManager.transparent,
                        unselectedLabelColor: ColorManager.white,
                        tabs: [
                          Tab(text: 'About Movie'),
                          Tab(text: 'Trailer'),
                        ],
                      ),
                      SizedBox(
                        height: 200,
                        child: TabBarView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50.0, vertical: 20),
                              child: Text(
                                controller.movie.value.about,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: ColorManager.white,
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  width: Get.width * .8,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    color: ColorManager.lightGrey,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.play_circle_outline_outlined,
                                      color: ColorManager.darkGrey,
                                      size: 50,
                                    ),
                                    onPressed: () {
                                      if (controller.internetService
                                              .internetConnected.value ==
                                          false) {
                                        Get.dialog(noInternetDialog(() {
                                          Get.back();
                                        }));
                                        return;
                                      }
                                      YoutubePlayerController videoController =
                                          YoutubePlayerController(
                                        initialVideoId:
                                            controller.trailerUrl.value,
                                        flags: const YoutubePlayerFlags(
                                          autoPlay: true,
                                          mute: false,
                                        ),
                                      );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => YoutubePlayer(
                                            controller: videoController,
                                            showVideoProgressIndicator: true,
                                            progressIndicatorColor:
                                                ColorManager.blue,
                                            progressColors:
                                                const ProgressBarColors(
                                              playedColor: ColorManager.blue,
                                              handleColor: ColorManager.blue,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
