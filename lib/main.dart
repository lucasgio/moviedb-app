import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:moviedb/src/pages/actor_detalle.dart';
import 'package:moviedb/src/pages/app_page.dart';
import 'package:moviedb/src/pages/home_page.dart';
import 'package:moviedb/src/pages/peliculas_detalle.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English, no country code
        const Locale('es', ''), // Spanish, no country code
      ],
      title: 'MovieData',
      initialRoute: '/',
      routes: {
        '/': (_) => HomePage(),
        'detalle': (_) => PeliculaDetalle(),
        'actordetalle': (_) => DetallesActor(),
        'funciona': (_) => AppInfo(),
      },
    );
  }
}

// chequea que haya conexion a internet
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
