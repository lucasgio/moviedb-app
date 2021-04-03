import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:moviedb/src/models/actores_model.dart';
import 'package:moviedb/src/models/pelicula_model.dart';
import 'package:moviedb/src/models/search_actor_model.dart';

class PeliculaProvider {
  String _apikey = "5962b5a668af804fc284b1e0a5ec4b9c";
  String _language = "es-ES";
  String _url = "api.themoviedb.org";
  int _pagePopular = 0;
  bool _cargando = false;
  List<Pelicula> _populares = [];
  // List<dynamic> generos = [];

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;
  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void diposeStream() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodeData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getMoviesPlayNow() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      "api_key": _apikey,
      "language": _language,
    });
    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];
    _cargando = true;
    _pagePopular++;
    final url = Uri.https(_url, '3/movie/popular', {
      "api_key": _apikey,
      "language": _language,
      "page": _pagePopular.toString()
    });

    final _resp = await _procesarRespuesta(url);
    _populares.addAll(_resp);
    popularesSink(_populares);
    _cargando = false;
    return _resp;
  }

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

  Future<List<Pelicula>> busquedaPeliculas(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      "api_key": _apikey,
      "language": _language,
      "query": query,
    });
    return await _procesarRespuesta(url);
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

  // Future<List> cargarGeneros() async {
  //   final resp = await rootBundle.loadString('assets/generos.json');
  //   Map<String, dynamic> dataGeneros = json.decode(resp);
  //   generos.add(dataGeneros['generos']);
  //   return generos;
  // }
}
