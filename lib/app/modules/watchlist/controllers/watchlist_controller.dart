import 'package:get/get.dart';
import 'package:movilar/app/data/movie.dart';
import 'package:movilar/app/modules/home/controllers/home_controller.dart';

class WatchlistController extends GetxController {
  var watchlist = <Movie>[].obs;
  HomeController homeController = Get.find();

  @override
  void onInit() {
    getWatchList();
    super.onInit();
  }

  void getWatchList() {
    watchlist.value = homeController.getWatchListMovies();
    update();
  }
}
