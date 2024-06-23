import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> writeWatchlist(String key, List<String> movieIds) async {
    await _storage.write(key: key, value: movieIds.join(','));
  }

  Future<List<String>> readWatchlist(String key) async {
    String? movieIds = await _storage.read(key: key);
    if (movieIds != null) {
      return movieIds.split(',');
    }
    return [];
  }

  Future<void> deleteWatchlist(String key) async {
    await _storage.delete(key: key);
  }
}
