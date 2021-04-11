import 'package:flutter/material.dart';
import 'package:moviedb/src/models/faq_model.dart';
import 'package:moviedb/src/providers/pelicula_provider.dart';
import 'package:slimy_card/slimy_card.dart';

class AppInfo extends StatefulWidget {
  AppInfo({Key key}) : super(key: key);

  @override
  _AppInfoState createState() => _AppInfoState();
}

class _AppInfoState extends State<AppInfo> {
  final _faq = PeliculaProvider();
  List<bool> isOpen;
  @override
  Widget build(BuildContext context) {
    final _screenwidth = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent.shade700,
        title: Text("Consejos Utiles"),
      ),
      body: FutureBuilder(
        future: _faq.cargarFaq(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Informacion>> snapshot) {
          if (snapshot.hasData) {
            final _resp = snapshot.data;
            print(_resp);
            return ListView(
              children: _resp
                  .map((element) => ListTile(
                        title: Text(element.ask),
                        subtitle: Text(element.answer),
                      ))
                  .toList(),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}