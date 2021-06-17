import 'package:flutter/material.dart';

// My imports
import 'package:connectivity/connectivity.dart';
import 'package:moviedb/src/providers/pelicula_provider.dart';
import 'package:moviedb/src/widgets/card_swiper.dart';
import 'package:moviedb/src/widgets/footer_app.dart';
import 'package:moviedb/src/widgets/menu_lateral.dart';
import 'package:moviedb/src/widgets/movie_horizontal.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:moviedb/src/widgets/pop_menu.dart';
import 'package:moviedb/src/widgets/swiper_card.dart';

class HomePage extends StatelessWidget {
  final _newmovie = new PeliculaProvider();
  @override
  Widget build(BuildContext context) {
    _checkInternet(context);
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
              SwiperCard(),
              FooterApp(),
            ],
          ),
        ));
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
