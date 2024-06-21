import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:movilar/app/modules/widgets/custom_app_bar.dart';
import 'package:movilar/app/modules/widgets/movie_detail_item.dart';
import 'package:movilar/app/resources/assets_manager.dart';
import 'package:movilar/app/resources/color_manager.dart';

import '../controllers/watchlist_controller.dart';

class WatchlistView extends StatelessWidget {
  const WatchlistView({super.key});
  @override
  Widget build(BuildContext context) {
    WatchlistController controller = Get.put(WatchlistController());
    return GetBuilder<WatchlistController>(
      init: WatchlistController(),
      initState: (_) {
        controller.getWatchList();
      },
      builder: (_) {
        return Scaffold(
          appBar: customAppBar("Watch list"),
          body: SingleChildScrollView(
            child: Obx(() => SizedBox(
                  height: Get.height,
                  child: ListView.builder(
                      itemCount: controller.watchlist.isEmpty
                          ? 1
                          : controller.watchlist.length,
                      itemBuilder: (context, index) {
                        if (controller.watchlist.isEmpty) {
                          return SizedBox(
                            height: Get.height * .8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  AssetsManager.folder,
                                  width: 100,
                                  height: 100,
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: Get.width * .35,
                                  child: const Text(
                                    'There is no movie yet!',
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
                                    'Find your movie by Type title, categories, years, etc ',
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
                              bottom: index == controller.watchlist.length - 1
                                  ? 50
                                  : 0,
                            ),
                            child: MovieDetailItem(
                                movie: controller.watchlist[index]),
                          );
                        }
                      }),
                )),
          ),
        );
      },
    );
  }
}
