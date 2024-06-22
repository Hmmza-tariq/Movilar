import 'package:get/get.dart';
import 'package:movilar/app/data/movie.dart';
import 'package:movilar/app/modules/watchlist/controllers/watchlist_controller.dart';
import 'package:movilar/app/services/internet_service.dart';
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
          ratings: "",
          id: "")
      .obs;
  var trailerUrl = ''.obs;
  var isWatchListed = false.obs;
  final MovieService _movieService = MovieService();
  final InternetService internetService = Get.find<InternetService>();
  WatchlistController watchlistController = Get.find();

  @override
  void onInit() {
    movie.value = Get.arguments;
    getDetails();
    super.onInit();
  }

  Future<void> getDetails() async {
    for (var id in watchlistController.watchLaterMoviesIDs) {
      if (id == movie.value.id) {
        isWatchListed.value = true;
        break;
      }
    }
    trailerUrl.value =
        await _movieService.getTrailer(movie.value.id, trailerUrl.value) ?? '';
  }

  void toggleWatchList() {
    if (watchlistController.watchLaterMoviesIDs.contains(movie.value.id)) {
      watchlistController.watchLaterMoviesIDs.remove(movie.value.id);
      watchlistController.watchlist
          .removeWhere((element) => element.id == movie.value.id);
      movie.value.isWatchListed = false;
      isWatchListed.value = false;
    } else {
      watchlistController.watchLaterMoviesIDs.add(movie.value.id);
      watchlistController.watchlist.add(movie.value);
      movie.value.isWatchListed = true;
      isWatchListed.value = true;
    }
    watchlistController.update();
  }
}
