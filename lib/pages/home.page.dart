import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../menu/drawer.widget.dart';


class Home extends StatelessWidget {
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: Text('Accueil')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 1.3,
        children: <Widget>[
          _buildCard(context, "Accueil", Icons.home, "/home"),
          _buildCard(context, "Autorisations en attente", Icons.pending, "/autorisationenattente"),
          _buildCard(context, "Autorisations acceptées", Icons.check, "/autorisationaccepte"),
          _buildCard(context, "Autorisations refusées", Icons.close, "/autorisationrefuse"),
          _buildCard(context, "Congés en attente", Icons.pending, "/Congenattente"),
          _buildCard(context, "Congés acceptés", Icons.check, "/congeaccepte"),
          _buildCard(context, "Congés refusés", Icons.close, "/congeRefusers"),
          _buildLogoutCard(context),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon, String route) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(
                  icon,
                  size: 28,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                title,
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () async {
          final prefs = await SharedPreferences.getInstance();
          final LocalStorage storage = new LocalStorage('localstorage_app');
          await prefs.clear();
          storage.clear();
          prefs.setBool("connecte", false);
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/authentification', (Route<dynamic> route) => false);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.logout,
                  size: 28,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                "Déconnexion",
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
    /*return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.blue,
      child: InkWell(
        onTap: () async {
          final prefs = await SharedPreferences.getInstance();
          final LocalStorage storage = new LocalStorage('localstorage_app');
          await prefs.clear();
          storage.clear();
          prefs.setBool("connecte", false);
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/authentification', (Route<dynamic> route) => false);
        },
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.logout,
                size: 50.0,
                color: Colors.white,
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                "Déconnexion",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );*/
  }
}
