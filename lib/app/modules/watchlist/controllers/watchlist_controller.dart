import 'package:get/get.dart';
import 'package:movilar/app/data/movie.dart';
import 'package:movilar/app/services/movie_service.dart';
import 'package:movilar/app/services/secure_storage_service.dart';

class WatchlistController extends GetxController {
  var watchlist = <Movie>[].obs;
  MovieService movieService = MovieService();
  var watchLaterMoviesIDs = <String>[].obs;
  var isLoading = true.obs;
  final SecureStorageService _secureStorageService = SecureStorageService();

  @override
  void onInit() async {
    super.onInit();
    await getWatchList();
  }

  Future<void> getWatchList() async {
    isLoading.value = true;
    try {
      watchlist.clear();
    } catch (e) {
      // debugPrint(e.toString());
    }
    watchLaterMoviesIDs.value =
        await _secureStorageService.readWatchlist('watchlist');
    for (var id in watchLaterMoviesIDs) {
      final movie = await movieService.getDetails(id);

      if (movie != null && !watchlist.contains(movie)) {
        watchlist.add(movie);
      }
    }
    isLoading.value = false;
    update();
  }

  Future<void> addToWatchList(String id) async {
    if (!watchLaterMoviesIDs.contains(id)) {
      watchLaterMoviesIDs.add(id);
      await _secureStorageService.writeWatchlist(
          'watchlist', watchLaterMoviesIDs);
      getWatchList();
    }
  }

  Future<void> removeFromWatchList(String id) async {
    if (watchLaterMoviesIDs.contains(id)) {
      watchLaterMoviesIDs.remove(id);
      await _secureStorageService.writeWatchlist(
          'watchlist', watchLaterMoviesIDs);
      getWatchList();
    }
  }
}
