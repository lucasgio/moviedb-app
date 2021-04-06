import 'dart:async';

import 'package:moviedb/src/models/pelicula_model.dart';

class PopularesStream {
  PopularesStream();

  final popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      popularesStreamController.sink.add;
  Stream<List<Pelicula>> get popularesStream =>
      popularesStreamController.stream;

  void diposeStream() {
    popularesStreamController?.close();
  }
}
