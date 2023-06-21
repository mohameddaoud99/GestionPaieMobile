import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyage/pages/AutorisationRefuse.page.dart';
import 'package:voyage/pages/authentification.page.dart';
import 'package:voyage/pages/Congenattente.page.dart';
import 'package:voyage/pages/autorisationenattente.page.dart';
import 'package:voyage/pages/home.page.dart';
import 'package:voyage/pages/inscription.page.dart';
import 'package:voyage/pages/Autorisationaccepte.page.dart';
import 'package:voyage/pages/congeRefusers.page.dart';
import 'package:voyage/pages/congeaccepte.page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routes = {
    '/home': (context) => Home(),
    '/inscription': (context) => Inscription(),
    '/authentification': (context) => Authentification(),
    '/autorisationrefuse': (context) => AutorisationrefusePage(),
    '/autorisationaccepte': (context) => AutorisationacceptePage(),
    '/autorisationenattente': (context) => AutorisationenattentePage(),
    '/congeaccepte': (context) => CongeacceptePage(),
    '/Congenattente': (context) => CongenattentePage(),

    '/congeRefusers': (context) => CongeRefusersPage(),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: routes,
        // home:  Inscription(),
        home: FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder:
                (BuildContext context, AsyncSnapshot<SharedPreferences> prefs) {
              var x = prefs.data;
              if (prefs.hasData) {
                bool conn = x?.getBool("connecte") ?? false;
                if (conn) return Home();
              }
              return Authentification();
            }));
  }
}
