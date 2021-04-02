class Actores {
  List<Actor> items = [];

  Actores.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var actor in jsonList) {
      final cast = new Actor.fromJsonMap(actor);
      items.add(cast);
    }
  }
}

class Actor {
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  String department;
  String job;

  Actor({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  Actor.fromJsonMap(Map<String, dynamic> jsonMap) {
    adult = jsonMap['adult'];
    gender = jsonMap['gender'];
    id = jsonMap['id'];
    knownForDepartment = jsonMap['known_for_department'];
    name = jsonMap['name'];
    originalName = jsonMap['original_name'];
    popularity = jsonMap['popularity'];
    profilePath = jsonMap['profile_path'];
    castId = jsonMap['cast_id'];
    character = jsonMap['character'];
    creditId = jsonMap['credit_id'];
    order = jsonMap['order'];
    department = jsonMap['department'];
  }

  getActorimg() {
    if (profilePath == null) {
      return "https://us.123rf.com/450wm/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-.jpg?ver=6";
    } else {
      return "https://image.tmdb.org/t/p/w500/$profilePath";
    }
  }
}
