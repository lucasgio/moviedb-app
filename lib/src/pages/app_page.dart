import 'package:flutter/material.dart';
import 'package:moviedb/src/models/faq_model.dart';
import 'package:moviedb/src/providers/pelicula_provider.dart';

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
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
