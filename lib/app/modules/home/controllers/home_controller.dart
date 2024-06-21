import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movilar/app/data/movie.dart';
import 'package:movilar/app/modules/mqtt/controllers/mqtt_listener.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var movies = <Movie>[].obs;
  var nowPlaying = <Movie>[].obs;
  var popular = <Movie>[].obs;
  var topRated = <Movie>[].obs;
  var upcoming = <Movie>[].obs;
  var selectedTabIndex = 0.obs;
  var watchLaterMovies = <String>[].obs;
  var isLoading = false.obs;

  final String apiKey = '856fcb83ecb826025083d8982930bad9';
  @override
  void onInit() {
    super.onInit();
    Get.put(MQTTListener());
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
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        movies.value = (data['results'] as List)
            .map((movie) => Movie.fromJson(movie))
            .toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch movies');
      }
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar('Error', 'Failed to fetch movies');
    }
    await Future.wait([
      fetchNowPlayingMovies(),
      fetchPopularMovies(),
      fetchTopRatedMovies(),
      fetchUpcomingMovies(),
    ]);

    isLoading.value = false;
  }

  Future<void> fetchNowPlayingMovies() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      nowPlaying.value = (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
    } else {
      Get.snackbar('Error', 'Failed to fetch Now Playing movies');
    }
  }

  Future<void> fetchPopularMovies() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      popular.value = (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
    } else {
      Get.snackbar('Error', 'Failed to fetch Popular movies');
    }
  }

  Future<void> fetchTopRatedMovies() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      topRated.value = (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
    } else {
      Get.snackbar('Error', 'Failed to fetch Top Rated movies');
    }
  }

  Future<void> fetchUpcomingMovies() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      upcoming.value = (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
    } else {
      Get.snackbar('Error', 'Failed to fetch Upcoming movies');
    }
  }
}
