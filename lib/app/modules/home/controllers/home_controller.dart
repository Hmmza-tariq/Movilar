import 'package:get/get.dart';
import 'package:movilar/app/data/movie.dart';
import 'package:movilar/app/helpers/database_helper.dart';
import 'package:movilar/app/modules/mqtt/controllers/mqtt_listener.dart';
import 'package:movilar/app/modules/watchlist/controllers/watchlist_controller.dart';
import 'package:movilar/app/modules/widgets/no_internet_dialog.dart';
import 'package:movilar/app/services/internet_service.dart';
import 'package:movilar/app/services/movie_service.dart';

class HomeController extends GetxController {
  var movies = <Movie>[].obs;
  var nowPlaying = <Movie>[].obs;
  var popular = <Movie>[].obs;
  var topRated = <Movie>[].obs;
  var upcoming = <Movie>[].obs;
  var selectedTabIndex = 0.obs;
  var isLoading = true.obs;

  final MovieService _movieService = MovieService();
  final InternetService internetService = Get.find<InternetService>();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  var categories = [
    'movies',
    'now_playing',
    'popular',
    'top_rated',
    'upcoming',
  ];
  @override
  void onInit() {
    super.onInit();

    internetService.listenInternet();
    Get.put(WatchlistController());
    internetService.internetConnected.listen((val) {
      Get.put(MQTTListener());
    });
    fetchMovies();
  }

  void changeTabIndex(int index) {
    selectedTabIndex.value = index;
  }

  List<Movie> searchMovie(String query) {
    if (query.isEmpty) {
      return [];
    }
    var result = movies
        .where((movie) =>
            movie.title.toLowerCase().contains(query.toLowerCase()) ||
            movie.genre.toLowerCase().contains(query.toLowerCase()) ||
            movie.year.toLowerCase().contains(query.toLowerCase()) ||
            movie.ratings.toLowerCase().contains(query.toLowerCase()) ||
            movie.duration.toLowerCase().contains(query.toLowerCase()) ||
            movie.about.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return result;
  }

  Future<void> fetchMovies() async {
    await internetService.checkInternet();
    if (!internetService.internetConnected.value) {
      movies.value = await _dbHelper.getMovies("movies");
      nowPlaying.value = await _dbHelper.getMovies("now_playing");
      popular.value = await _dbHelper.getMovies("popular");
      topRated.value = await _dbHelper.getMovies("top_rated");
      upcoming.value = await _dbHelper.getMovies("upcoming");
      isLoading.value = false;
      await Get.dialog(noInternetDialog(() {
        Get.back();
      }));
      return;
    }

    isLoading.value = true;
    try {
      movies.value = await _dbHelper.getMovies("movies");
      nowPlaying.value = await _dbHelper.getMovies("now_playing");
      popular.value = await _dbHelper.getMovies("popular");
      topRated.value = await _dbHelper.getMovies("top_rated");
      upcoming.value = await _dbHelper.getMovies("upcoming");

      isLoading.value = false;

      var fetchedMovies = await _movieService.fetchMovies('upcoming');
      var fetchedNowPlaying = await _movieService.fetchMovies('now_playing');
      var fetchedPopular = await _movieService.fetchMovies('popular');
      var fetchedTopRated = await _movieService.fetchMovies('top_rated');
      var fetchedUpcoming = await _movieService.fetchMovies('upcoming');

      movies.value = fetchedMovies;
      nowPlaying.value = fetchedNowPlaying;
      popular.value = fetchedPopular;
      topRated.value = fetchedTopRated;
      upcoming.value = fetchedUpcoming;

      await _dbHelper.deleteMovies('movies');
      await _dbHelper.deleteMovies('now_playing');
      await _dbHelper.deleteMovies('popular');
      await _dbHelper.deleteMovies('top_rated');
      await _dbHelper.deleteMovies('upcoming');
      for (var movie in fetchedMovies) {
        await _dbHelper.insertMovie(movie, "movies");
      }
      for (var movie in fetchedNowPlaying) {
        await _dbHelper.insertMovie(movie, "now_playing");
      }
      for (var movie in fetchedPopular) {
        await _dbHelper.insertMovie(movie, "popular");
      }
      for (var movie in fetchedTopRated) {
        await _dbHelper.insertMovie(movie, "top_rated");
      }
      for (var movie in fetchedUpcoming) {
        await _dbHelper.insertMovie(movie, "upcoming");
      }
    } catch (e) {
      // debugPrint(e.toString());
      isLoading.value = false;
    }
  }
}
