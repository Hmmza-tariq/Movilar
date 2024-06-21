// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import '../modules/bluetooth/bindings/bluetooth_binding.dart';
import '../modules/bluetooth/views/bluetooth_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/movie_detail/bindings/movie_detail_binding.dart';
import '../modules/movie_detail/views/movie_detail_view.dart';
import '../modules/mqtt/bindings/mqtt_binding.dart';
import '../modules/mqtt/views/mqtt_view.dart';
import '../modules/searches/bindings/searches_binding.dart';
import '../modules/searches/views/searches_view.dart';
import '../modules/watchlist/bindings/watchlist_binding.dart';
import '../modules/watchlist/views/watchlist_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SEARCHES,
      page: () => const SearchesView(),
      binding: SearchesBinding(),
    ),
    GetPage(
      name: _Paths.WATCHLIST,
      page: () => const WatchlistView(),
      binding: WatchlistBinding(),
    ),
    GetPage(
      name: _Paths.BLUETOOTH,
      page: () => const BluetoothView(),
      binding: BluetoothBinding(),
    ),
    GetPage(
      name: _Paths.MQTT,
      page: () => const MqttView(),
      binding: MqttBinding(),
    ),
    GetPage(
      name: _Paths.MOVIE_DETAIL,
      page: () => const MovieDetailView(),
      binding: MovieDetailBinding(),
    ),
  ];
}
