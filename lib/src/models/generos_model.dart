class GeneroList {
  final List<Generos> genrs = [];

  GeneroList.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listgeneros = new Generos.fromJsonMap(item);
      genrs.add(listgeneros);
    }
  }
}

class Generos {
  int id;
  String name;

  Generos({
    this.id,
    this.name,
  });

  Generos.fromJsonMap(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    name = jsonMap['name'];
  }
}
