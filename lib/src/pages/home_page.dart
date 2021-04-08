import 'package:flutter/material.dart';
import 'package:moviedb/src/providers/pelicula_provider.dart';
import 'package:moviedb/src/search/data_search.dart';
import 'package:moviedb/src/search/search_actor.dart';
import 'package:moviedb/src/widgets/card_swiper.dart';
import 'package:moviedb/src/widgets/movie_horizontal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  final _newmovie = new PeliculaProvider();
  final _color = Colors.indigo;
  // final String _direccionLinkedIn = 'https://linkedin.com/in/iosvany-alvarez/';

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
      _opciones(Icons.supervised_user_circle, "Como funciona MovieDB"),
      _opciones(Icons.support_agent, "FAQ"),
      _opciones(Icons.developer_board, "Desarrollador"),
      SizedBox(
        height: 200.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _redesSociales(FontAwesomeIcons.linkedinIn, _color),
          _redesSociales(FontAwesomeIcons.twitter, _color),
          _redesSociales(FontAwesomeIcons.instagram, _color),
          _redesSociales(FontAwesomeIcons.globe, _color),
        ],
      )
    ]);
  }

  Widget _opciones(icon, texto) {
    return ListTile(
      leading: Icon(
        icon,
        color: _color,
      ),
      title: Text(texto),
    );
  }

  Widget _redesSociales(icon, color) {
    return IconButton(
        icon: FaIcon(
          icon,
          size: 35.0,
          color: _color,
        ),
        onPressed: () {});
  }
}

enum MenuOption { peliculas, actores }
