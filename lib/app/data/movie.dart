class Movie {
  final String id;
  String title;
  String banner;
  String image;
  String about;
  String year;
  String duration;
  String ratings;
  String genre;
  String trailer;
  bool? isWatchListed;

  Movie({
    required this.id,
    required this.title,
    required this.banner,
    required this.image,
    required this.about,
    required this.year,
    required this.duration,
    required this.ratings,
    required this.genre,
    required this.trailer,
    this.isWatchListed = false,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    String genre = '';
    try {
      var temp =
          (json['genres'] as List).map((genre) => genre['name']).join(', ');
      genre = temp.split(',').length > 1
          ? temp.split(',').sublist(0, 1).join(', ')
          : temp;
    } catch (e) {
      try {
        genre = json['genres'];
      } catch (e) {
        genre = 'genre';
      }
    }

    return Movie(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      banner: json['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
          : "",
      image: json['backdrop_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['backdrop_path']}'
          : "",
      about: json['overview'] ?? '',
      year: json['release_date']?.substring(0, 4) ?? '0000',
      duration: '${json['runtime'] ?? 0} min',
      ratings: json['vote_average'] != null
          ? json['vote_average'].toString()
          : '0.0',
      genre: genre,
      trailer: '',
      isWatchListed: json['isWatchListed'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': banner,
      'backdrop_path': image,
      'overview': about,
      'release_date': year,
      'runtime': duration,
      'vote_average': ratings,
      'genres': genre,
      'trailer': trailer,
      'isWatchListed': isWatchListed == true ? 1 : 0,
    };
  }
}
