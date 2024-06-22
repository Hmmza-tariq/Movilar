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
    watchlist.clear();
    for (var id in watchLaterMoviesIDs) {
      await getDetails(id);
    }
    isLoading.value = false;

    update();
  }

  Future<void> getDetails(String id) async {
    final movie = await _movieService.getDetails(id);
    if (movie != null) {
      watchlist.add(movie);
    }
  }

  Future<List<Movie>> getWatchlistMovies() async {
    List<Movie> movies = [];
    for (var id in watchLaterMoviesIDs) {
      var movie = await _movieService.getDetails(id);
      if (movie != null) {
        movies.add(movie);
      }
    }
    return movies;
  }
}
