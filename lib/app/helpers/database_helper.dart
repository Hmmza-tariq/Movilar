import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:movilar/app/data/movie.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'temp2.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE movies (
      id TEXT PRIMARY KEY,
      title TEXT,
      overview TEXT,
      release_date TEXT,
      runtime TEXT,
      genres TEXT,
      trailer TEXT,
      poster_path TEXT,
      backdrop_path TEXT,
      vote_average TEXT,
      isWatchListed INTEGER
    );
  ''');

    await db.execute('''
    CREATE TABLE now_playing (
      id TEXT PRIMARY KEY,
      title TEXT,
      overview TEXT,
      release_date TEXT,
      runtime TEXT,
      genres TEXT,
      trailer TEXT,
      poster_path TEXT,
      backdrop_path TEXT,
      vote_average TEXT,
      isWatchListed INTEGER
    );
  ''');

    await db.execute('''
    CREATE TABLE popular (
      id TEXT PRIMARY KEY,
      title TEXT,
      overview TEXT,
      release_date TEXT,
      runtime TEXT,
      genres TEXT,
      trailer TEXT,
      poster_path TEXT,
      backdrop_path TEXT,
      vote_average TEXT,
      isWatchListed INTEGER
    );
  ''');

    await db.execute('''
    CREATE TABLE top_rated (
      id TEXT PRIMARY KEY,
      title TEXT,
      overview TEXT,
      release_date TEXT,
      runtime TEXT,
      genres TEXT,
      trailer TEXT,
      poster_path TEXT,
      backdrop_path TEXT,
      vote_average TEXT,
      isWatchListed INTEGER
    );
  ''');

    await db.execute('''
    CREATE TABLE upcoming (
      id TEXT PRIMARY KEY,
      title TEXT,
      overview TEXT,
      release_date TEXT,
      runtime TEXT,
      genres TEXT,
      trailer TEXT,
      poster_path TEXT,
      backdrop_path TEXT,
      vote_average TEXT,
      isWatchListed INTEGER
    );
  ''');
  }

  Future<void> insertMovie(Movie movie, String name) async {
    final db = await database;
    await db.insert(name, movie.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Movie>> getMovies(String name) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(name);
    return List.generate(maps.length, (i) {
      return Movie.fromJson(maps[i]);
    });
  }

  Future<void> deleteMovies(String name) async {
    final db = await database;
    await db.delete(name);
  }
}
