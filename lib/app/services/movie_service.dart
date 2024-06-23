import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movilar/app/data/movie.dart';
import 'package:movilar/app/helpers/database_helper.dart';

class MovieService {
  Dio dio = Dio();
  final String apiKey = dotenv.env['API_KEY'] ?? '';
  final String baseURL = dotenv.env['BASE_URL'] ?? '';
  DatabaseHelper dbHelper = DatabaseHelper();

  Future<List<Movie>> fetchMovies(String endpoint) async {
    try {
      final response =
          await dio.get('$baseURL/movie/$endpoint?api_key=$apiKey');
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
            await dbHelper.insertMovie(movie, endpoint);
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
          await dio.get('$baseURL/movie/$id?api_key=$apiKey');
      if (detailResponse.statusCode == 200) {
        final detailData = detailResponse.data;
        final movie = Movie.fromJson(detailData);
        return movie;
      } else {
        debugPrint('ERROR: Failed to fetch movie details');
      }
    } catch (e) {
      // debugPrint(e.toString());
    }
    return null;
  }

  Future<String?> getTrailer(String id, String trailerUrl) async {
    try {
      final response =
          await dio.get('$baseURL/movie/$id/videos?api_key=$apiKey');
      if (response.statusCode == 200) {
        final data = response.data;
        if (data['results'].isNotEmpty) {
          return data['results'][0]['key'];
        }
      } else {
        debugPrint('ERROR: Failed to fetch trailer');
      }
    } catch (e) {
      // debugPrint(e.toString());
    }
    return null;
  }
}
