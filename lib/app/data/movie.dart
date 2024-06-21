class Movie {
  final String id;
  final String title;
  final String banner;
  final String image;
  final String about;
  final String year;
  final String duration;
  final String ratings;
  final String genre;
  final String trailer;
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
      year: json['release_date']?.substring(0, 4) ?? '',
      duration: '', // Duration is not available in this API endpoint
      ratings: json['vote_average'].toStringAsFixed(1),
      genre: '', // Genre is not available in this API endpoint
      trailer: '', // Trailer is not available in this API endpoint
    );
  }
}
