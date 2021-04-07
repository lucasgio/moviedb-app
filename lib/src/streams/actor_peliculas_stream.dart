import 'dart:async';

import 'package:moviedb/src/models/search_actor_model.dart';

class ActorStream {
  ActorStream();

  final actorPeliculasController =
      StreamController<List<SearchActor>>.broadcast();

  Function(List<SearchActor>) get popularesSink =>
      actorPeliculasController.sink.add;
  Stream<List<SearchActor>> get popularesStream =>
      actorPeliculasController.stream;

  void diposeStream() {
    actorPeliculasController?.close();
  }
}
