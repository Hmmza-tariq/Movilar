import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movilar/app/services/secure_storage_service.dart';
import 'secure_storage_service_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  late SecureStorageService secureStorageService;
  late MockFlutterSecureStorage mockSecureStorage;

  setUp(() {
    mockSecureStorage = MockFlutterSecureStorage();
    secureStorageService = SecureStorageService();
    secureStorageService.storage = mockSecureStorage;
  });

  group('writeWatchlist', () {
    test('writes the movie IDs to secure storage', () async {
      const key = 'watchlist';
      final movieIds = ['1', '2', '3'];

      when(mockSecureStorage.write(key: key, value: anyNamed('value')))
          .thenAnswer((_) async => Future.value());

      await secureStorageService.writeWatchlist(key, movieIds);

      verify(mockSecureStorage.write(
        key: key,
        value: movieIds.join(','),
      )).called(1);
    });
  });

  group('readWatchlist', () {
    test('reads the movie IDs from secure storage', () async {
      const key = 'watchlist';
      const storedValue = '1,2,3';

      when(mockSecureStorage.read(key: key))
          .thenAnswer((_) async => storedValue);

      final result = await secureStorageService.readWatchlist(key);

      expect(result, ['1', '2', '3']);
      verify(mockSecureStorage.read(key: key)).called(1);
    });

    test('returns an empty list when there is no value in secure storage',
        () async {
      const key = 'watchlist';

      when(mockSecureStorage.read(key: key)).thenAnswer((_) async => null);

      final result = await secureStorageService.readWatchlist(key);

      expect(result, []);
      verify(mockSecureStorage.read(key: key)).called(1);
    });
  });

  group('deleteWatchlist', () {
    test('deletes the watchlist from secure storage', () async {
      const key = 'watchlist';

      when(mockSecureStorage.delete(key: key))
          .thenAnswer((_) async => Future.value());

      await secureStorageService.deleteWatchlist(key);

      verify(mockSecureStorage.delete(key: key)).called(1);
    });
  });
}
