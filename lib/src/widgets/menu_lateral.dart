import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/menu_image.jpg"),
                      fit: BoxFit.cover)),
              child: Container(),
            ),
            Text(
              "MovieData",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50.0,
            ),
            _opcionesMenu(context, Icons.stream, "Como funciona?", 1),
            Divider(),
            SizedBox(
              height: 350.0,
            ),
            Divider(
              thickness: 3.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _redeSociales(FontAwesomeIcons.linkedinIn),
                _redeSociales(FontAwesomeIcons.instagram),
                _redeSociales(FontAwesomeIcons.twitter),
                _redeSociales(FontAwesomeIcons.globe),
              ],
            ),
            Divider(
              thickness: 3.0,
            )
          ],
        ),
      ),
    );
  }

  Widget _opcionesMenu(BuildContext context, IconData icon, mensaje, index) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.redAccent,
      ),
      title: Text(
        mensaje,
        style: TextStyle(decorationColor: Colors.white),
      ),
      onTap: () {
        _chooseOpt(context, index);
      },
    );
  }

  Widget _redeSociales(icon) {
    return IconButton(
        icon: FaIcon(icon), color: Colors.redAccent, onPressed: () {});
  }

  void _chooseOpt(context, index) {
    if (index == 1) {
      Navigator.pushNamed(context, "funciona");
    } else {
      Navigator.pushNamed(context, "faq");
    }
  }
}
