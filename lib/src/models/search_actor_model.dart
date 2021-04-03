class BusquedaActor {
  final List<SearchActor> listasActores = [];

  BusquedaActor.formJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var i in jsonList) {
      final actors = new SearchActor.fromJsonMap(i);
      listasActores.add(actors);
    }
  }
}

class SearchActor {
  int id;
  List<dynamic> detalle;
  String knownForDepartment;
  String name;
  double popularity;
  String profilePath;

  SearchActor({
    this.id,
    this.detalle,
    this.knownForDepartment,
    this.name,
    this.popularity,
    this.profilePath,
  });

  SearchActor.fromJsonMap(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    detalle = jsonMap['known_for'];
    knownForDepartment = jsonMap['known_for_department'];
    name = jsonMap['name'];
    popularity = jsonMap['popularity'];
    profilePath = jsonMap['profile_path'];
  }

  getPostActor() {
    if (profilePath == null) {
      return "https://us.123rf.com/450wm/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-.jpg?ver=6";
    } else {
      return "https://image.tmdb.org/t/p/w500/$profilePath";
    }
  }
}
