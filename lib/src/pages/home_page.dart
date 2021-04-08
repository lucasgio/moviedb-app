import 'package:flutter/material.dart';
import 'package:moviedb/src/providers/pelicula_provider.dart';
import 'package:moviedb/src/search/data_search.dart';
import 'package:moviedb/src/search/search_actor.dart';
import 'package:moviedb/src/widgets/card_swiper.dart';
import 'package:moviedb/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final _newmovie = new PeliculaProvider();

  @override
  Widget build(BuildContext context) {
    _newmovie.getPopulares();
    return Scaffold(
        // backgroundColor: Colors.black87,
        appBar: AppBar(
          title: Text(
            "Peliculas",
          ),
          backgroundColor: Colors.indigoAccent.shade700,
          actions: <Widget>[
            _popMenuButton(context),
          ],
        ),
        drawer: _menuLateral(),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "Play Now",
                style: TextStyle(fontSize: 20.0),
              ),
              _swiperTarjeta(),
              _footer(context),
            ],
          ),
        ));
  }

  Widget _swiperTarjeta() {
    return FutureBuilder(
      future: _newmovie.getMoviesPlayNow(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(
            peliculas: snapshot.data,
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: 400.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              "Peliculas mas Vistas",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          StreamBuilder(
            stream: _newmovie.moviesPopularesStream.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientepage: _newmovie.getPopulares,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _popMenuButton(BuildContext context) {
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

  Widget _menuLateral() {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Center(
                child: Text(
                  'MovieDB',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            _menuOpciones(),
          ],
        ),
      ),
    );
  }

  Widget _menuOpciones() {
    return Column(children: [
      ListTile(
        leading: Icon(Icons.live_help),
        title: Text('Como funciona MovieDB'),
      ),
      ListTile(
        leading: Icon(Icons.support_agent),
        title: Text('FAQ'),
      ),
      ListTile(
        leading: Icon(Icons.question_answer),
        title: Text('Quienes Somos'),
      ),
      Row(
        children: [],
      )
    ]);
  }
}

enum MenuOption { peliculas, actores }
