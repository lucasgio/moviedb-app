import 'package:flutter/material.dart';
import 'package:moviedb/src/models/pelicula_model.dart';
import 'package:moviedb/src/providers/pelicula_provider.dart';

class DataSearch extends SearchDelegate {
  final pelicula = new PeliculaProvider();
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
    //  Crea los resultados que mvamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //  Muestra las sugerencias al usuario
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
        future: pelicula.busquedaPeliculas(query),
        builder:
            (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if (snapshot.hasData) {
            final busquedas = snapshot.data;
            return ListView(
              children: busquedas
                  .map((busqueda) => Hero(
                        tag: busqueda.uniqueid = "${busqueda.id} - search",
                        child: ListTile(
                          leading: FadeInImage(
                            placeholder: AssetImage("assets/no-image.jpg"),
                            image: NetworkImage(busqueda.getPosterImg()),
                            width: 50.0,
                            fit: BoxFit.contain,
                          ),
                          title: Text(busqueda.title),
                          subtitle: Text(busqueda.originalTitle),
                          onTap: () {
                            close(context, null);
                            Navigator.pushNamed(context, 'detalle',
                                arguments: busqueda);
                          },
                        ),
                      ))
                  .toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    }
  }
}
