import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:movilar/app/modules/widgets/custom_app_bar.dart';
import 'package:movilar/app/modules/widgets/movie_detail_item.dart';
import 'package:movilar/app/resources/assets_manager.dart';
import 'package:movilar/app/resources/color_manager.dart';

import '../controllers/searches_controller.dart';

class SearchesView extends GetView<SearchesController> {
  const SearchesView({super.key});
  @override
  Widget build(BuildContext context) {
    SearchesController controller = Get.put(SearchesController());
    return Scaffold(
      appBar: customAppBar("Search", icon: Icons.info_outline_rounded),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
              child: TextField(
                autofocus: true,
                controller: controller.searchController,
                cursorColor: ColorManager.blue,
                style: const TextStyle(
                    fontFamily: 'Montserrat',
                    color: ColorManager.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: ColorManager.lightGrey),
                  fillColor: ColorManager.darkGrey,
                  filled: true,
                  suffixIconConstraints: const BoxConstraints(
                    minWidth: 24,
                    minHeight: 24,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Transform.flip(
                      transformHitTests: false,
                      flipX: true,
                      child: SvgPicture.asset(
                        AssetsManager.search,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            // const SizedBox(height: 16),
            Obx(() => SizedBox(
                  height: Get.height * .8,
                  child: ListView.builder(
                      itemCount: controller.searchResult.isEmpty
                          ? 1
                          : controller.searchResult.length,
                      itemBuilder: (context, index) {
                        if (controller.searchResult.isEmpty) {
                          return SizedBox(
                            height: Get.height * .6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  AssetsManager.groupSearch,
                                  width: 100,
                                  height: 100,
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: Get.width * .35,
                                  child: const Text(
                                    'we are sorry, we can not find the movie :(',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: ColorManager.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: Get.width * .45,
                                  child: const Text(
                                    'Find your movie by Type title, categories, years, etc :)',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: ColorManager.lightestGrey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom:
                                  index == controller.searchResult.length - 1
                                      ? 90
                                      : 0,
                            ),
                            child: MovieDetailItem(
                                movie: controller.searchResult[index]),
                          );
                        }
                      }),
                )),
          ],
        ),
      ),
    );
  }
}
