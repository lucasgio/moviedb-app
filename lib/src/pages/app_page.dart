import 'package:flutter/material.dart';

class AppInfo extends StatefulWidget {
  AppInfo({Key key}) : super(key: key);

  @override
  _AppInfoState createState() => _AppInfoState();
}

class _AppInfoState extends State<AppInfo> {
  List<bool> isOpen;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent.shade700,
        title: Text("Como funciona MovieDB"),
      ),
      body: ExpansionPanelList(children: [
        ExpansionPanel(
            headerBuilder: (context, isOpen) {
              return Text("Hello");
            },
            body: Text("Hello im open"),
            isExpanded: isOpen[0])
      ], expansionCallback: (i, isOpen) => setState(() => isOpen = !isOpen)),
    );
  }
}
