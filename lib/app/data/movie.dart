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

  Movie(
      {required this.title,
      required this.about,
      required this.year,
      required this.duration,
      required this.genre,
      required this.trailer,
      required this.banner,
      required this.image,
      required this.ratings,
      required this.id,
      this.isWatchListed = false});

  Movie.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        banner = json['banner'],
        image = json['image'],
        about = json['about'],
        year = json['year'],
        duration = json['duration'],
        ratings = json['ratings'],
        genre = json['genre'],
        id = json['id'],
        trailer = json['trailer'],
        isWatchListed = json['isWatchListed'] ?? false;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'banner': banner,
        'image': image,
        'about': about,
        'year': year,
        'duration': duration,
        'ratings': ratings,
        'genre': genre,
        'trailer': trailer,
        'isWatchListed': isWatchListed,
      };
}
