import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:movilar/app/data/movie.dart';
import 'package:movilar/app/helpers/database_helper.dart';

class MovieService {
  final Dio _dio = Dio();
  final String apiKey = dotenv.env['API_KEY'] ?? '';
  final String baseURL = dotenv.env['BASE_URL'] ?? '';
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<List<Movie>> fetchMovies(String endpoint) async {
    try {
      final response =
          await _dio.get('$baseURL/movie/$endpoint?api_key=$apiKey');
      if (response.statusCode == 200) {
        final data = response.data;
        var temp = (data['results'] as List)
            .map((movie) => Movie.fromJson(movie).id)
            .toList();
        List<Movie> result = [];
        for (var id in temp) {
          final movie = await getDetails(id);
          if (movie != null) {
            result.add(movie);
            await _dbHelper.insertMovie(movie, endpoint);
          }
        }
        return result;
      } else {
        throw Exception('Failed to fetch movies');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Movie?> getDetails(String id) async {
    try {
      final detailResponse =
          await _dio.get('$baseURL/movie/$id?api_key=$apiKey');
      if (detailResponse.statusCode == 200) {
        final detailData = detailResponse.data;
        final movie = Movie.fromJson(detailData);
        return movie;
      } else {
        Get.snackbar('Error', 'Failed to fetch movie details');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    return null;
  }

  Future<String?> getTrailer(String id, String trailerUrl) async {
    try {
      final response =
          await _dio.get('$baseURL/movie/$id/videos?api_key=$apiKey');
      if (response.statusCode == 200) {
        final data = response.data;
        if (data['results'].isNotEmpty) {
          return data['results'][0]['key'];
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch trailer data');
      }
    } catch (e) {
      Get.snackbar('Error', "Internet connection error. Please try again.");
    }
    return null;
  }
}
