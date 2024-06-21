import 'dart:convert';

import 'package:get/get.dart';
import 'package:movilar/app/data/movie.dart';
import 'package:movilar/app/modules/home/controllers/home_controller.dart';
import 'package:movilar/app/modules/watchlist/controllers/watchlist_controller.dart';
import 'package:http/http.dart' as http;

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
  final String apiKey = '856fcb83ecb826025083d8982930bad9';
  var trailerUrl = ''.obs;

  @override
  void onInit() {
    movie.value = Get.arguments;
    getDetails();
    super.onInit();
  }

  void getDetails() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/${movie.value.id}/videos?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['results'].isNotEmpty) {
        trailerUrl.value =
            'https://www.youtube.com/watch?v=${data['results'][0]['key']}';
      }
    } else {
      Get.snackbar('Error', 'Failed to fetch Now Playing movies');
    }
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
