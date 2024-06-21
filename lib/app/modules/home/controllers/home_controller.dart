import 'package:get/get.dart';
import 'package:movilar/app/data/movie.dart';
import 'package:movilar/app/resources/assets_manager.dart';

class HomeController extends GetxController {
  List<Movie> movies = [];
  var selectedTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    movies = [
      Movie(
          title: "Spiderman No Way Home",
          about: "From DC Comics",
          year: "2019",
          duration: "139",
          genre: "action",
          trailer: "abc.com",
          banner: AssetsManager.d1,
          image: AssetsManager.d1,
          ratings: "9.8",
          id: "1"),
      Movie(
          title: "Spiderman No Way Home",
          about: "From DC Comics",
          year: "2019",
          duration: "139",
          genre: "action",
          trailer: "abc.com",
          banner: AssetsManager.d2,
          image: AssetsManager.d2,
          ratings: "9.8",
          id: "2"),
      Movie(
          title: "Spiderman No Way Home",
          about:
              "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.",
          year: "2019",
          duration: "139",
          genre: "action",
          trailer: "abc.com",
          banner: AssetsManager.d7,
          image: AssetsManager.d3,
          ratings: "9.8",
          id: "3"),
      Movie(
          title: "Spiderman No Way Home",
          about: "From DC Comics",
          year: "2019",
          duration: "139",
          genre: "action",
          trailer: "abc.com",
          banner: AssetsManager.d4,
          image: AssetsManager.d4,
          ratings: "9.8",
          id: "4"),
      Movie(
          title: "Spiderman No Way Home",
          about: "From DC Comics",
          year: "2019",
          duration: "139",
          genre: "action",
          trailer: "abc.com",
          banner: AssetsManager.d5,
          image: AssetsManager.d5,
          ratings: "9.8",
          id: "5"),
      Movie(
          title: "Spiderman No Way Home",
          about: "From DC Comics",
          year: "2019",
          duration: "139",
          genre: "action",
          trailer: "abc.com",
          banner: AssetsManager.d6,
          image: AssetsManager.d6,
          ratings: "9.8",
          id: "6"),
      Movie(
          title: "Spiderman No Way Home",
          about: "From DC Comics",
          year: "2019",
          duration: "139",
          genre: "action",
          trailer: "abc.com",
          banner: AssetsManager.d7,
          image: AssetsManager.d7,
          ratings: "9.8",
          id: "7"),
      Movie(
          title: "Spiderman No Way Home",
          about: "From DC Comics",
          year: "2019",
          duration: "139",
          genre: "action",
          trailer: "abc.com",
          banner: AssetsManager.d7,
          image: AssetsManager.d7,
          ratings: "9.8",
          id: "8"),
    ];
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

  List<Movie> getWatchListMovies() {
    var result = movies.where((movie) => movie.isWatchListed!).toList();
    return result;
  }
}
