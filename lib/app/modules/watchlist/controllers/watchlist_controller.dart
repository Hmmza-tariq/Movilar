import 'package:get/get.dart';
import 'package:movilar/app/data/movie.dart';
import 'package:movilar/app/services/movie_service.dart';

class WatchlistController extends GetxController {
  var watchlist = <Movie>[].obs;
  final MovieService _movieService = MovieService();
  var watchLaterMoviesIDs = <String>[].obs;
  var isLoading = true.obs;
  @override
  void onInit() {
    getWatchList();
    super.onInit();
  }

  void getWatchList() async {
    isLoading.value = true;
    for (var id in watchLaterMoviesIDs) {
      final movie = await _movieService.getDetails(id);
      if (movie != null && !watchLaterMoviesIDs.contains(movie.id)) {
        watchlist.add(movie);
      }
    }
    isLoading.value = false;

    update();
  }
}
