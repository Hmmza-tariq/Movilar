import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movilar/app/modules/bluetooth/views/bluetooth_view.dart';
import 'package:movilar/app/modules/home/widgets/movie_category_view.dart';
import 'package:movilar/app/modules/home/widgets/movie_poster.dart';
import 'package:movilar/app/modules/mqtt/views/mqtt_view.dart';
import 'package:movilar/app/modules/searches/views/searches_view.dart';
import 'package:movilar/app/modules/watchlist/views/watchlist_view.dart';
import 'package:movilar/app/resources/assets_manager.dart';
import 'package:movilar/app/resources/color_manager.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.selectedTabIndex.value == 4
          ? const MqttView()
          : controller.selectedTabIndex.value == 3
              ? const BluetoothView()
              : controller.selectedTabIndex.value == 2
                  ? const WatchlistView()
                  : controller.selectedTabIndex.value == 1
                      ? const SearchesView()
                      : SafeArea(
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Row(
                                        children: [
                                          Text(
                                            "What do you want to watch?",
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: ColorManager.white,
                                            ),
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.refresh,
                                            size: 24,
                                            color: ColorManager.white,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      TextField(
                                        cursorColor: ColorManager.blue,
                                        onTap: () {
                                          controller.changeTabIndex(1);
                                        },
                                        style: const TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: ColorManager.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                        decoration: InputDecoration(
                                          hintText: 'Search',
                                          hintStyle: const TextStyle(
                                              color: ColorManager.lightGrey),
                                          fillColor: ColorManager.darkGrey,
                                          filled: true,
                                          suffixIconConstraints:
                                              const BoxConstraints(
                                            minWidth: 24,
                                            minHeight: 24,
                                          ),
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
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
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            borderSide: BorderSide.none,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  height: Get.height * .3,
                                  width: Get.width,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller.movies.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          left: (index == 0) ? 16 : 0,
                                          right: index ==
                                                  controller.movies.length - 1
                                              ? 16
                                              : 0,
                                        ),
                                        child: MoviePoster(
                                          movie: controller.movies[index],
                                          index: index,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: DefaultTabController(
                                    length: 4,
                                    child: Column(
                                      children: [
                                        const TabBar(
                                          indicatorColor:
                                              ColorManager.lightGrey,
                                          dividerColor:
                                              ColorManager.transparent,
                                          labelColor: ColorManager.white,
                                          unselectedLabelColor:
                                              ColorManager.white,
                                          isScrollable: true,
                                          tabAlignment: TabAlignment.start,
                                          tabs: [
                                            Tab(text: 'Now playing'),
                                            Tab(text: 'Upcoming'),
                                            Tab(text: 'Top rated'),
                                            Tab(text: 'Popular'),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Get.height * .35,
                                          child: TabBarView(
                                            children: [
                                              MovieCategoryView(
                                                  category: 'Now playing',
                                                  movies: controller.movies),
                                              MovieCategoryView(
                                                  category: 'Upcoming',
                                                  movies: controller.movies),
                                              MovieCategoryView(
                                                  category: 'Top rated',
                                                  movies: controller.movies),
                                              MovieCategoryView(
                                                  category: 'Popular',
                                                  movies: controller.movies),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
      bottomNavigationBar: Obx(() {
        return Container(
          margin: EdgeInsets.zero,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: ColorManager.blue,
                width: 1,
              ),
            ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: ColorManager.primary,
            currentIndex: controller.selectedTabIndex.value,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            onTap: controller.changeTabIndex,
            selectedItemColor: ColorManager.blue,
            unselectedItemColor: ColorManager.lightGrey,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            items: [
              BottomNavigationBarItem(
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    controller.selectedTabIndex.value == 0
                        ? ColorManager.blue
                        : ColorManager.lightGrey,
                    BlendMode.srcIn,
                  ),
                  child: SvgPicture.asset(AssetsManager.home, width: 24),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    controller.selectedTabIndex.value == 1
                        ? ColorManager.blue
                        : ColorManager.lightGrey,
                    BlendMode.srcIn,
                  ),
                  child: SvgPicture.asset(AssetsManager.search, width: 24),
                ),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    controller.selectedTabIndex.value == 2
                        ? ColorManager.blue
                        : ColorManager.lightGrey,
                    BlendMode.srcIn,
                  ),
                  child: SvgPicture.asset(AssetsManager.watchList, width: 24),
                ),
                label: 'Watch list',
              ),
              BottomNavigationBarItem(
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    controller.selectedTabIndex.value == 3
                        ? ColorManager.blue
                        : ColorManager.lightGrey,
                    BlendMode.srcIn,
                  ),
                  child: SvgPicture.asset(AssetsManager.bluetooth, width: 24),
                ),
                label: 'BT',
              ),
              BottomNavigationBarItem(
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    controller.selectedTabIndex.value == 4
                        ? ColorManager.blue
                        : ColorManager.lightGrey,
                    BlendMode.srcIn,
                  ),
                  child: SvgPicture.asset(AssetsManager.mqtt, width: 24),
                ),
                label: 'MQTT',
              ),
            ],
          ),
        );
      }),
    );
  }
}
