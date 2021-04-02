import 'package:flutter/material.dart';
import 'package:moviedb/src/models/search_actor_model.dart';
import 'package:moviedb/src/providers/pelicula_provider.dart';

class ActorSearch extends SearchDelegate {
  final actor = new PeliculaProvider();
  String seleccion = '';

  @override
  List<Widget> buildActions(BuildContext context) {
    //  Acciones del appbar
    return <Widget>[
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //  Icono del  appbar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    //  Crea los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //  Muestra las sugerencias al usuario
    print(query);
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
        future: actor.procesarRespuestaActor(query),
        builder:
            (BuildContext context, AsyncSnapshot<List<SearchActor>> snapshot) {
          if (snapshot.hasData) {
            final busquedas = snapshot.data;
            return ListView(
              children: busquedas
                  .map((busqueda) => ListTile(
                        leading: FadeInImage(
                          placeholder: AssetImage("assets/no-image.jpg"),
                          image: NetworkImage(busqueda.getPostActor()),
                          width: 50.0,
                          fit: BoxFit.contain,
                        ),
                        title: Text(busqueda.name),
                        subtitle: Text(busqueda.knownForDepartment),
                        onTap: () {
                          close(context, null);
                          Navigator.pushNamed(context, 'detalle',
                              arguments: busqueda);
                        },
                      ))
                  .toList(),
            );
          } else {
            return Center(
              child: Text("No se encontro ningun resultado"),
            );
          }
        },
      );
    }
  }
}
