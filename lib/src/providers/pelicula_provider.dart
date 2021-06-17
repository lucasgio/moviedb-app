import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

// My imports
import 'package:moviedb/src/bloc/populares_block.dart';
import 'package:moviedb/src/models/faq_model.dart';
import 'package:moviedb/src/models/pelicula_model.dart';

class PeliculaProvider {
  String _apikey = "5962b5a668af804fc284b1e0a5ec4b9c";
  String _language = "es-ES";
  String _url = "api.themoviedb.org";
  int _pagePopular = 0;
  bool _cargando = false;
  List<Pelicula> _populares = [];
  List<dynamic> faq = [];

  final moviesPopularesStream = new PopularesBloc();

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
    moviesPopularesStream.popularesSink(_populares);
    _cargando = false;
    return _resp;
  }

  Future<List<Pelicula>> busquedaPeliculas(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      "api_key": _apikey,
      "language": _language,
      "query": query,
    });
    return await _procesarRespuesta(url);
  }

  Future<List<Informacion>> cargarFaq() async {
    final _resp = await rootBundle.loadString('assets/faq.json');
    Map dataMap = jsonDecode(_resp);
    final faq = new Informacion.fromJsonList(dataMap['faq']);
    return faq.faq;
  }
}
