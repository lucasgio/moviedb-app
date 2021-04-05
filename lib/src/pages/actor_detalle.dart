import 'package:flutter/material.dart';

import 'package:moviedb/src/models/search_actor_model.dart';
import 'package:moviedb/src/providers/pelicula_provider.dart';

class DetallesActor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SearchActor detalles = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _crearAppBar(detalles),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 20.0,
              ),
              _posterTiltulo(context, detalles),
              // _descripcion(detalles),
              _crearPeliDetalles(detalles),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _crearAppBar(SearchActor detalles) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: FadeInImage(
          placeholder: AssetImage("assets/loading.gif"),
          image: NetworkImage(detalles.getPostActor()),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTiltulo(BuildContext context, SearchActor detalles) {
    // final DateTime _stringDate = DateTime.parse(detalles.releaseDate);
    // final String _date = formatDate(_stringDate, [yyyy]);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(detalles.getPostActor()),
              height: 150.0,
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detalles.name,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(Icons.star_border_outlined),
                    Text(
                      detalles.popularity.toString(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.insert_emoticon),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(detalles.knownForDepartment),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearPeliDetalles(SearchActor detalles) {
    final detallesActor = new PeliculaProvider();
    return FutureBuilder(
      future: detallesActor.getActorPeliculas(detalles.name),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _crearPeliActor(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearPeliActor(List<SearchActor> detalles) {
    return SizedBox(
      height: 400.0,
      child: ListView.builder(
          itemCount: detalles.length,
          itemBuilder: (BuildContext context, i) =>
              _crearListadoPeliculas(detalles[i])),
    );
  }

  Widget _crearListadoPeliculas(SearchActor detalles) {
    return ListTile(
      leading: FadeInImage(
        placeholder: AssetImage('assets/no-image.jpg'),
        image: NetworkImage(detalles.getAcotrPeli()),
      ),
      title: Text(detalles.title),
      subtitle: Text(detalles.overview),
    );
  }
}
