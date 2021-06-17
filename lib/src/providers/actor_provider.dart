import 'dart:convert';
import 'package:http/http.dart' as http;

// My imports
import 'package:moviedb/src/bloc/actor_block.dart';
import 'package:moviedb/src/models/actores_model.dart';
import 'package:moviedb/src/models/search_actor_model.dart';

class ActorProvider {
  String _apikey = "5962b5a668af804fc284b1e0a5ec4b9c";
  String _language = "es-ES";
  String _url = "api.themoviedb.org";
  final actorPeliculasDetalles = new ActorBloc();

  Future<List<Actor>> getCast(String peliId) async {
    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      "api_key": _apikey,
      "language": _language,
    });
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final cast = new Actores.fromJsonList(decodeData['cast']);

    return cast.items;
  }

  Future<List<SearchActor>> procesarRespuestaActor(String query) async {
    final url = Uri.https(_url, '3/search/person', {
      "api_key": _apikey,
      "language": _language,
      "query": query,
    });
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final actores = new BusquedaActor.formJsonList(decodeData['results']);
    return actores.listasActores;
  }

  Future<List<SearchActor>> getActorPeliculas(String query) async {
    final url = Uri.https(_url, '3/search/person', {
      "api_key": _apikey,
      "language": _language,
      "query": query,
    });
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final actores =
        new BusquedaActor.procesarDetallesPeliculas(decodeData['results']);
    return actores.listaPeliculasDetallesActor;
  }
}
