import 'package:get/get.dart';
import 'package:movilar/app/data/movie.dart';
import 'package:movilar/app/modules/watchlist/controllers/watchlist_controller.dart';

class MovieDetailController extends GetxController {
  var movie = Movie(
          title: "",
          about: "",
          year: "",
          duration: "",
          genre: "",
          trailer: "",
          banner: "",
          image: "",
          ratings: "ratings",
          id: "")
      .obs;

  @override
  void onInit() {
    movie.value = Get.arguments;
    super.onInit();
  }

  void toggleWatchList() {
    movie.update((val) {
      movie.value.isWatchListed = !movie.value.isWatchListed!;
    });
    WatchlistController watchlistController = Get.find();
    watchlistController.getWatchList();
  }
}
