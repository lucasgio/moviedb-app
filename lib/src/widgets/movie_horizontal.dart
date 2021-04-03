import 'package:flutter/material.dart';
import 'package:moviedb/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientepage;
  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  MovieHorizontal({this.peliculas, this.siguientepage});

  @override
  Widget build(BuildContext context) {
    final _screensize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 100) {
        siguientepage();
      }
    });

    return Container(
      height: _screensize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemBuilder: (context, i) => _crearTarjeta(context, peliculas[i]),
        itemCount: peliculas.length,
      ),
    );
  }

  Widget _crearTarjeta(BuildContext context, Pelicula pelicula) {
    pelicula.uniqueid = '${pelicula.id}- poster';
    final tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueid,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage("assets/no-image.jpg"),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 130.0,
              ),
            ),
          ),
          SizedBox(
            height: 0.5,
          ),
          Text(
            pelicula.title,
            style: Theme.of(context).textTheme.caption,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );
  }
}
