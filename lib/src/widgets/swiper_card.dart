import 'package:flutter/material.dart';
import 'package:moviedb/src/providers/pelicula_provider.dart';
import 'package:moviedb/src/widgets/card_swiper.dart';

class SwiperCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _swiperCard = PeliculaProvider();

    return FutureBuilder(
      future: _swiperCard.getMoviesPlayNow(),
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
}
