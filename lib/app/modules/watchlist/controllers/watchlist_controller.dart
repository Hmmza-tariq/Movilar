import 'dart:convert';

import 'package:get/get.dart';
import 'package:movilar/app/data/movie.dart';
import 'package:movilar/app/modules/home/controllers/home_controller.dart';
import 'package:http/http.dart' as http;

class WatchlistController extends GetxController {
  var watchlist = <Movie>[].obs;
  HomeController homeController = Get.find();
  final String apiKey = '856fcb83ecb826025083d8982930bad9';

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
    final response = await http.get(
        Uri.parse('https://api.themoviedb.org/3/movie/$id?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final movie = Movie.fromJson(data);
      if (watchlist.contains(movie)) {
        return;
      }
      watchlist.add(movie);
    } else {
      Get.snackbar('Error', 'Failed to fetch Now Playing movies');
    }
  }
}
