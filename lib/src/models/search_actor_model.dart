class BusquedaActor {
  List<SearchActor> listasActores = [];
  List<SearchActor> listaPeliculasDetallesActor = [];

  BusquedaActor.formJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var i in jsonList) {
      final actors = new SearchActor.fromJsonMap(i);
      listasActores.add(actors);
    }
  }

  BusquedaActor.procesarDetallesPeliculas(List<dynamic> jsonListDetalles) {
    if (jsonListDetalles == null) return;
    for (var detallesPeliculas in jsonListDetalles) {
      final _resp = detallesPeliculas['known_for'] as List;
      listaPeliculasDetallesActor =
          _resp.map((e) => SearchActor.detallesActor(e)).toList();
    }
  }
}

class SearchActor {
  int id;
  String uniqueid;
  String knownForDepartment;
  String name;
  double popularity;
  String profilePath;
  List<dynamic> knownFor;

  String mediaType;
  String originalLanguage;
  String originalTitle;
  String overview;
  String posterPath;
  String releaseDate;
  String title;
  double voteAverage;
  String backdropPath;

  SearchActor({
    this.id,
    this.knownForDepartment,
    this.name,
    this.popularity,
    this.profilePath,
    this.mediaType,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.voteAverage,
    this.backdropPath,
    this.knownFor,
  });

  SearchActor.fromJsonMap(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    knownForDepartment = jsonMap['known_for_department'];
    name = jsonMap['name'];
    popularity = jsonMap['popularity'] / 1;
    profilePath = jsonMap['profile_path'];
    knownFor = jsonMap['known_for'];
  }

  SearchActor.detallesActor(Map<String, dynamic> detallesMap) {
    mediaType = detallesMap['media_type'];
    originalLanguage = detallesMap['original_language'];
    originalTitle = detallesMap['original_title'];
    overview = detallesMap['overview'];
    posterPath = detallesMap['poster_path'];
    releaseDate = detallesMap['release_date'];
    title = detallesMap['title'];
    backdropPath = detallesMap['backdrop_path'];
  }

  getPostActor() {
    if (profilePath == null) {
      return "https://us.123rf.com/450wm/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-.jpg?ver=6";
    } else {
      return "https://image.tmdb.org/t/p/w500/$profilePath";
    }
  }

  getAcotrPeli() {
    if (posterPath == null) {
      return "https://us.123rf.com/450wm/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-.jpg?ver=6";
    } else {
      return "https://image.tmdb.org/t/p/w500/$posterPath";
    }
  }
}
