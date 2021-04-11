import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/src/providers/pelicula_provider.dart';
import 'package:moviedb/src/widgets/card_swiper.dart';
import 'package:moviedb/src/widgets/menu_lateral.dart';
import 'package:moviedb/src/widgets/movie_horizontal.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:moviedb/src/widgets/pop_menu.dart';

class HomePage extends StatelessWidget {
  final _newmovie = new PeliculaProvider();
  @override
  Widget build(BuildContext context) {
    _checkInternet(context);
    _newmovie.getPopulares();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Peliculas",
          ),
          backgroundColor: Colors.indigoAccent.shade700,
          actions: <Widget>[
            PopMenu(),
          ],
        ),
        drawer: MenuLateral(),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
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
              "Peliculas mas vistas",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 20.0,
                  color: Colors.redAccent),
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

  _checkInternet(BuildContext context) async {
    final _result = await Connectivity().checkConnectivity();
    if (_result == ConnectivityResult.none) {
      Flushbar(
        flushbarStyle: FlushbarStyle.FLOATING,
        message: "No hay conexion a internet",
        duration: Duration(seconds: 5),
        isDismissible: false,
        flushbarPosition: FlushbarPosition.BOTTOM,
        backgroundColor: Colors.indigo,
      )..show(context);
    } else if (_result == ConnectivityResult.mobile ||
        _result == ConnectivityResult.wifi) {
      Flushbar(
        flushbarStyle: FlushbarStyle.FLOATING,
        message: "Estas en linea",
        duration: Duration(seconds: 5),
        isDismissible: false,
        flushbarPosition: FlushbarPosition.BOTTOM,
        backgroundColor: Colors.green,
      )..show(context);
    }
  }
}
