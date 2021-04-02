class Peliculas {
  List<Pelicula> items = [];

  Peliculas();

  Peliculas.fromJsonList(List<dynamic> jsonlist) {
    if (jsonlist == null) return;

    for (var item in jsonlist) {
      final pelicula = new Pelicula.fromJasonMap(item);
      items.add(pelicula);
    }
  }
}

class Pelicula {
  bool adult;
  String backdropPath;
  List<dynamic> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Pelicula({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
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

  Pelicula.fromJasonMap(Map<String, dynamic> mapRecive) {
    adult = mapRecive['adult'];
    backdropPath = mapRecive['backdrop_path'];
    genreIds = mapRecive['genre_ids'];
    id = mapRecive['id'];
    originalLanguage = mapRecive['original_language'];
    originalTitle = mapRecive['original_title'];
    overview = mapRecive['overview'];
    popularity = mapRecive['popularity'] / 1;
    posterPath = mapRecive['poster_path'];
    releaseDate = mapRecive['release_date'];
    title = mapRecive['title'];
    video = mapRecive['video'];
    voteAverage = mapRecive['vote_average'] / 1;
    voteCount = mapRecive['vote_count'];
  }

  getPosterImg() {
    if (posterPath == null) {
      return "https://us.123rf.com/450wm/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-.jpg?ver=6";
    } else {
      return "https://image.tmdb.org/t/p/w500/$posterPath";
    }
  }

  getBackgroundImg() {
    if (backdropPath == null) {
      return "https://us.123rf.com/450wm/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-.jpg?ver=6";
    } else {
      return "https://image.tmdb.org/t/p/w500/$backdropPath";
    }
  }
}
