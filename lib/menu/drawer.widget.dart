import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/global.params.dart';
import 'package:localstorage/localstorage.dart';

class MyDrawer extends StatelessWidget {
  late SharedPreferences prefs;
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(children: [
      DrawerHeader(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.white, Colors.blue])),
          child: Center(
              child: CircleAvatar(
            backgroundImage: AssetImage("assets/profil.jpg"),
            radius: 80,
          ))),
      ListTile(
          title: Text('Accueil', style: TextStyle(fontSize: 17)),
          leading: Icon(Icons.home, color: Colors.blue),
          trailing: Icon(Icons.arrow_right, color: Colors.blue),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, "/home");
          }),
      ListTile(
          title:
              Text('Autorisations en attente', style: TextStyle(fontSize: 17)),
          leading: Icon(Icons.pending, color: Colors.blue),
          trailing: Icon(Icons.arrow_right, color: Colors.blue),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, "/autorisationenattente");
          }),
      ListTile(
        title: Text('Autorisations acceptées', style: TextStyle(fontSize: 17)),
        leading: Icon(Icons.check, color: Colors.blue),
        trailing: Icon(Icons.arrow_right, color: Colors.blue),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.pushNamed(context, "/autorisationaccepte");
        },
      ),
      ListTile(
        title: Text('Autorisations refusées', style: TextStyle(fontSize: 17)),
        leading: Icon(Icons.close, color: Colors.blue),
        trailing: Icon(Icons.arrow_right, color: Colors.blue),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.pushNamed(context, "/autorisationrefuse");
        },
      ),
      ListTile(
        title: Text("Congés en attente", style: TextStyle(fontSize: 17)),
        leading: Icon(Icons.pending, color: Colors.blue),
        trailing: Icon(Icons.arrow_right, color: Colors.blue),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.pushNamed(context, "/Congenattente");
        },
      ),
      ListTile(
        title: Text("Congés acceptés", style: TextStyle(fontSize: 17)),
        leading: Icon(Icons.check, color: Colors.blue),
        trailing: Icon(Icons.arrow_right, color: Colors.blue),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.pushNamed(context, "/congeaccepte");
        },
      ),
      ListTile(
        title: Text("Congés refusés", style: TextStyle(fontSize: 17)),
        leading: Icon(Icons.close, color: Colors.blue),
        trailing: Icon(Icons.arrow_right, color: Colors.blue),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.pushNamed(context, "/congeRefusers");
        },
      ),
      ListTile(
        title: Text("Déconnexion", style: TextStyle(fontSize: 17)),
        leading: Icon(Icons.logout, color: Colors.blue),
        trailing: Icon(Icons.arrow_right, color: Colors.blue),
        onTap: () async {
          final prefs = await SharedPreferences.getInstance();
          final LocalStorage storage = new LocalStorage('localstorage_app');
          await prefs.clear();
          storage.clear();
          prefs.setBool(("connecte"), false);
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/authentification', (Route<dynamic> route) => false);
        },
      ),
    ]));
  }
}
