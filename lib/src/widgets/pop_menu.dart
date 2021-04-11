import 'package:flutter/material.dart';
import 'package:moviedb/src/search/data_search.dart';
import 'package:moviedb/src/search/search_actor.dart';

class PopMenu extends StatelessWidget {
  const PopMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuOption>(
      icon: Icon(Icons.search_rounded),
      itemBuilder: (context) {
        return <PopupMenuEntry<MenuOption>>[
          PopupMenuItem(
            child: Text("Busqueda por Pelicula"),
            value: MenuOption.peliculas,
          ),
          PopupMenuItem(
            child: Text("Busqueda por Actor"),
            value: MenuOption.actores,
          ),
        ];
      },
      onSelected: (value) {
        if (value == MenuOption.peliculas) {
          return showSearch(context: context, delegate: DataSearch());
        } else {
          return showSearch(context: context, delegate: ActorSearch());
        }
      },
    );
  }
}

enum MenuOption { peliculas, actores }
