import 'package:flutter/material.dart';

class GlobalParams {
  static List<Map<String, dynamic>> menus = [
    {
      "title": "Accueil",
      "icon": Icon(
        Icons.photo,
        color: Colors.blue,
      ),
      "route": "/home"
    },
    {
      "title": "Autorisations en attente",
      "icon": Icon(
        Icons.pending,
        color: Colors.blue,
      ),
      "route": "/autorisationenattente"
    },
    {
      "title": "Autorisations acceptées",
      "icon": Icon(
        Icons.check,
        color: Colors.blue,
      ),
      "route": "/autorisationaccepte"
    },
    {
      "title": "Autorisations refusées",
      "icon": Icon(
        Icons.close,
        color: Colors.blue,
      ),
      "route": "/autorisationrefuse"
    },
    {
      "title": "Congé accepté",
      "icon": Icon(
        Icons.location_city,
        color: Colors.blue,
      ),
      "route": "/congeaccepte"
    },
    {
      "title": "Congé en attente",
      "icon": Icon(
        Icons.contact_page,
        color: Colors.blue,
      ),
      "route": "/Congenattente"
    },
    {
      "title": "congé refuser",
      "icon": Icon(
        Icons.insert_drive_file,
        color: Colors.blue,
      ),
      "route": "/congeRefusers"
    },
    {
      "title": "Déconnexion",
      "icon": Icon(
        Icons.logout,
        color: Colors.blue,
      ),
      "route": "/authentification"
    },
  ];
  static List<Map<String, dynamic>> acceuil = [
    {
      "image": AssetImage(
        'assets/meteo.png',
      ),
      "route": "/autorisationaccepte"
    },
    {
      "image": AssetImage(
        'assets/meteo.png',
      ),
      "route": "/autorisationrefuse"
    },
    {
      "image": AssetImage(
        'assets/gallerie.png',
      ),
      "route": "/autorisationenattente"
    },
    {
      "image": AssetImage(
        'assets/pays.png',
      ),
      "route": "/congeaccepte"
    },
    {
      "image": AssetImage(
        'assets/contact.png',
      ),
      "route": "/Congenattente"
    },
    {
      "image": AssetImage(
        'assets/parametres.png',
      ),
      "route": "/congeRefusers"
    },
    {
      "image": AssetImage(
        'assets/deconnexion.png',
      ),
      "route": "/authentification"
    },
  ];
}
