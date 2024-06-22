import 'package:get/get.dart';
import 'package:movilar/app/data/movie.dart';
import 'package:movilar/app/modules/mqtt/controllers/mqtt_listener.dart';
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
  var watchLaterMovies = <String>[].obs;
  var isLoading = false.obs;

  final MovieService _movieService = MovieService();
  final InternetService internetService = Get.find<InternetService>();

  @override
  void onInit() {
    super.onInit();
    internetService.listenInternet();
    if (internetService.internetConnected.value) {
      Get.put(MQTTListener());
    }
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

    // print('Internet: ${internetConnected.value}');
    if (!internetService.internetConnected.value) {
      await Get.dialog(noInternetDialog(() {
        Get.back();
      }));
      return;
    }

    isLoading.value = true;
    try {
      movies.value = await _movieService.fetchMovies('upcoming');
      nowPlaying.value = await _movieService.fetchMovies('now_playing');
      popular.value = await _movieService.fetchMovies('popular');
      topRated.value = await _movieService.fetchMovies('top_rated');
      upcoming.value = await _movieService.fetchMovies('upcoming');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    isLoading.value = false;
  }
}
