import 'package:get/get.dart';
import 'package:movilar/app/data/movie.dart';
import 'package:movilar/app/modules/home/controllers/home_controller.dart';
import 'package:movilar/app/services/movie_service.dart';

class WatchlistController extends GetxController {
  var watchlist = <Movie>[].obs;
  HomeController homeController = Get.find();
  final MovieService _movieService = MovieService();

  @override
  void onInit() {
    getWatchList();
    super.onInit();
  }

  void getWatchList() {
    for (var movie in homeController.watchLaterMovies) {
      getDetails(movie);
    }
    update();
  }

  void getDetails(String id) async {
    final movie = await _movieService.getDetails(id);
    if (movie != null) {
      watchlist.add(movie);
    }
    if (watchlist.contains(movie)) {
      return;
    } else {
      Get.snackbar('Error', 'Failed to fetch Now Playing movies');
    }
  }
}
