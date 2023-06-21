import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class Authentification extends StatelessWidget {
  late SharedPreferences prefs;
  TextEditingController txt_login = new TextEditingController();
  TextEditingController txt_password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Authentification')),
        body: SingleChildScrollView(
            child: Center(
                child: Container(
                    color: Colors.white,
                    child: Padding(
                        padding: const EdgeInsets.all(36.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 300.0,
                                child: Image.asset(
                                  "loginpartner.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                child: TextFormField(
                                  controller: txt_login,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.person),
                                      hintText: "Utilisateur",
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(width: 1),
                                          borderRadius:
                                              BorderRadius.circular(32.0))),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                child: TextFormField(
                                  obscureText: true,
                                  controller: txt_password,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.password),
                                      hintText: "Mot de passe",
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(width: 1),
                                          borderRadius:
                                              BorderRadius.circular(32.0))),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                              ),
                              Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: Color(0xff01A0C7),
                                  child: MaterialButton(
                                    minWidth: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    onPressed: () {
                                      _onAuthentification(context);
                                    },
                                    child: Text(
                                      'Connexion',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  )),

                            ]))))));
  }

  Future<void> _onAuthentification(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
  //  String log = prefs.getString("login") ?? '';
 //   String psw = prefs.getString("password") ?? '';

    if (!txt_login.text.isEmpty  && !txt_password.text.isEmpty) {

      var produitObject ={
        "compteuser": txt_login.text,
        "MotDePasse": txt_password.text

      };

      Map<String,String> headers = {'Content-Type':'application/json','accept' : 'application/json'};
      final config = {
        'Access-Control-Allow-Origin': '*',
      };
      final response = await http.post(
        Uri.parse('https://localhost:44367/api/Login/LoginAdmin'),
        headers: headers,
        body: jsonEncode(produitObject),
      );
      print(response.body.toString());
      // print(response.statusCode);


        try {


          if (response.statusCode == 200) {
            final adminDetails = jsonDecode(response.body)['AdminDetails'];



            final LocalStorage storage = new LocalStorage('localstorage_app');
            SharedPreferences prefs = await SharedPreferences.getInstance();

            prefs.setString("CompteUser", adminDetails['compteuser']);
            prefs.setString("MotDePasse", adminDetails['motdepasse']);
            prefs.setString("MotDePasse", adminDetails['DERSOC']);

            storage.setItem("CompteUser", adminDetails['compteuser']);
            storage.setItem('MotDePasse', adminDetails['motdepasse']);
            storage.setItem('DERSOC', adminDetails['DERSOC']);

            await http.get(
              Uri.parse('https://localhost:44367/api/ChoixBD?dbName=${adminDetails['DERSOC']}'),
              headers: config,
            );
            Navigator.pushNamed(context, '/inscription');

          } else {
            throw Exception('Erreur lors de l\'appel API');
          }
        } catch (e) {
          print(e);
        }





    } else {
      throw Exception("can't load author");
    }


  }
}
