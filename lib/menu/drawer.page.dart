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

      //Parcourir les à ments du menu
      ...(GlobalParams.menus as List).map((item) {
        return ListTile(
          title: Text(
            '${item['title']}',
            style: TextStyle(fontSize: 22),
          ),
          leading: item['icon'],
          trailing: Icon(
            Icons.arrow_right,
            color: Colors.blue,
          ),
          onTap: () async {
            if ('${item['title']}' != "Déconnexion") {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "${item["'route"]}");
            } else {
              prefs = await SharedPreferences.getInstance();
              prefs.setBool("connecte", false);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/authentification', (Route<dynamic> route) => false);
            }
          },
        );
      }),

      ListTile(
          title: Text('Accueil', style: TextStyle(fontSize: 22)),
          leading: Icon(Icons.home, color: Colors.blue),
          trailing: Icon(Icons.arrow_right, color: Colors.blue),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, "/home");
          }),
      ListTile(
          title:
              Text('Autorisation en attente', style: TextStyle(fontSize: 22)),
          leading: Icon(Icons.photo, color: Colors.blue),
          trailing: Icon(Icons.arrow_right, color: Colors.blue),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, "/galleautorisationenattenterie");
          }),

      ListTile(
        title: Text('Autorisation accepte', style: TextStyle(fontSize: 22)),
        leading: Icon(Icons.sunny_snowing, color: Colors.blue),
        trailing: Icon(Icons.arrow_right, color: Colors.blue),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.pushNamed(context, "/autorisationaccepte");
        },
      ),

      ListTile(
        title: Text('Autorisation refusé', style: TextStyle(fontSize: 22)),
        leading: Icon(Icons.sunny_snowing, color: Colors.blue),
        trailing: Icon(Icons.arrow_right, color: Colors.blue),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.pushNamed(context, "/autorisationrefuse");
        },
      ),

      ListTile(
        title: Text("Conge accepte", style: TextStyle(fontSize: 22)),
        leading: Icon(Icons.location_city, color: Colors.blue),
        trailing: Icon(Icons.arrow_right, color: Colors.blue),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.pushNamed(context, "/congeaccepte");
        },
      ),

      ListTile(
        title: Text("Conge en attente", style: TextStyle(fontSize: 22)),
        leading: Icon(Icons.contact_page, color: Colors.blue),
        trailing: Icon(Icons.arrow_right, color: Colors.blue),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.pushNamed(context, "/Congenattente");
        },
      ),

      ListTile(
        title: Text("Conge refuser", style: TextStyle(fontSize: 22)),
        leading: Icon(Icons.insert_drive_file, color: Colors.blue),
        trailing: Icon(Icons.arrow_right, color: Colors.blue),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.pushNamed(context, "/congeRefusers");
        },
      ),
      ListTile(
        title: Text("Déconnexion", style: TextStyle(fontSize: 22)),
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
