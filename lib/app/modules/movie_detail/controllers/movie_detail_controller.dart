import 'package:get/get.dart';
import 'package:movilar/app/data/movie.dart';
import 'package:movilar/app/modules/home/controllers/home_controller.dart';
import 'package:movilar/app/modules/watchlist/controllers/watchlist_controller.dart';
import 'package:movilar/app/services/movie_service.dart';

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
  var trailerUrl = ''.obs;
  final MovieService _movieService = MovieService();

  @override
  void onInit() {
    movie.value = Get.arguments;
    getDetails();
    super.onInit();
  }

  Future<void> getDetails() async {
    trailerUrl.value =
        await _movieService.getTrailer(movie.value.id, trailerUrl.value) ?? '';
    movie.value = await _movieService.getDetails(movie.value.id) ?? movie.value;
  }

  void toggleWatchList() {
    HomeController homeController = Get.find();
    WatchlistController watchlistController = Get.find();
    if (homeController.watchLaterMovies.contains(movie.value.id)) {
      homeController.watchLaterMovies.remove(movie.value.id);
      watchlistController.watchlist
          .removeWhere((element) => element.id == movie.value.id);
    } else {
      homeController.watchLaterMovies.add(movie.value.id);
      watchlistController.getDetails(movie.value.id);
    }
    homeController.update();
    watchlistController.update();
  }
}
