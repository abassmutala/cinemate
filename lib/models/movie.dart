class Movie {
  final bool? adult;
  final String? backdropPath;
  final List? genreIds;
  final List? genres;
  final int id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final dynamic voteAverage;
  final int? voteCount;

  Movie({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.genres,
    required this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory Movie.fromMap(Map<String, dynamic> mapData) {
    return Movie(
      id: mapData["id"],
      adult: mapData["adult"],
      backdropPath: mapData["backdrop_path"],
      genreIds: mapData["genre_ids"],
      genres: mapData["genres"],
      originalLanguage: mapData["original_language"],
      originalTitle: mapData["original_title"],
      overview: mapData["overview"],
      popularity: mapData["popularity"],
      posterPath: mapData["poster_path"],
      releaseDate: mapData["release_date"],
      title: mapData["title"],
      video: mapData["video"],
      voteAverage: mapData["vote_average"],
      voteCount: mapData["vote_count"],
    );
  }
}
