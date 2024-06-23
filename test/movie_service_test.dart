import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movilar/app/helpers/database_helper.dart';
import 'package:movilar/app/services/movie_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_service_test.mocks.dart';

@GenerateMocks([Dio, DatabaseHelper])
void main() {
  late MovieService movieService;
  late MockDio mockDio;
  late MockDatabaseHelper mockDbHelper;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
  });

  setUp(() {
    mockDio = MockDio();
    mockDbHelper = MockDatabaseHelper();
    movieService = MovieService();
    movieService.dio = mockDio;
    movieService.dbHelper = mockDbHelper;
  });

  group('fetchMovies', () {
    test('returns a list of movies when the call completes successfully',
        () async {
      final responsePayload = {
        'results': [
          {'id': '1'},
          {'id': '2'},
        ],
      };
      final detailPayload1 = {
        'id': '1',
        'title': 'Movie 1',
      };
      final detailPayload2 = {
        'id': '2',
        'title': 'Movie 2',
      };

      when(mockDio.get(any)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 200,
            data: responsePayload,
          ));
      when(mockDio.get(argThat(contains('/1'))))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: ''),
                statusCode: 200,
                data: detailPayload1,
              ));
      when(mockDio.get(argThat(contains('/2'))))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: ''),
                statusCode: 200,
                data: detailPayload2,
              ));

      when(mockDbHelper.insertMovie(any, any)).thenAnswer((_) async => 1);

      final movies = await movieService.fetchMovies('popular');

      expect(movies.length, 2);
      expect(movies[0].id, '1');
      expect(movies[0].title, 'Movie 1');
      expect(movies[1].id, '2');
      expect(movies[1].title, 'Movie 2');
    });

    test('throws an exception when the call completes with an error', () async {
      when(mockDio.get(any)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 404,
          ));

      expect(() => movieService.fetchMovies('popular'), throwsException);
    });
  });

  group('getDetails', () {
    test('returns a movie when the call completes successfully', () async {
      final detailPayload = {
        'id': '1',
        'title': 'Movie 1',
      };

      when(mockDio.get(any)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 200,
            data: detailPayload,
          ));

      final movie = await movieService.getDetails('1');

      expect(movie, isNotNull);
      expect(movie?.id, '1');
      expect(movie?.title, 'Movie 1');
    });

    test('returns null when the call completes with an error', () async {
      when(mockDio.get(any)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 404,
          ));

      final movie = await movieService.getDetails('1');

      expect(movie, isNull);
    });
  });

  group('getTrailer', () {
    test('returns a trailer key when the call completes successfully',
        () async {
      final responsePayload = {
        'results': [
          {'key': 'trailer_key'},
        ],
      };

      when(mockDio.get(any)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 200,
            data: responsePayload,
          ));

      final trailerKey = await movieService.getTrailer('1', '');

      expect(trailerKey, 'trailer_key');
    });

    test('returns null when the call completes with an error', () async {
      when(mockDio.get(any)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 404,
          ));

      final trailerKey = await movieService.getTrailer('1', '');

      expect(trailerKey, isNull);
    });
  });
}
