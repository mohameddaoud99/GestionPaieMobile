import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
class Inscription extends StatelessWidget {
  late SharedPreferences prefs;

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
                                  "inscription.jpg",
                                  fit: BoxFit.contain,
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
                                      _onInscrire(context);
                                    },
                                    child: Text(
                                      'Inscription',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  )),

                            ]))))));
  }

  Future<void> _onInscrire(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    if (!txt_password.text.isEmpty) {



      final url = Uri.https('localhost:44367', '/api/Personnel/GetEmployee', {'CIN': txt_password.text});
      final response = await http.get(url, headers: {'Access-Control-Allow-Origin': '*'});

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != "") {
          print(data);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final LocalStorage storage = new LocalStorage('localstorage_app');
          prefs.setString('MATREmployee', data['MATR']);
          prefs.setString('NOMPRENOM1Employee', data['NOMPRENOM1']);


          storage.setItem('MATREmployee', data['MATR']);
          storage.setItem('NOMPRENOM1Employee', data['NOMPRENOM1']);

          prefs.setString("password", txt_password.text);
          prefs.setBool("connecte", true);
          Navigator.pop(context);
          Navigator.pushNamed(context, '/home');


        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Vérifier les champs'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        print('Erreur: ${response.statusCode}');
      }


    } else {
      const snackBar = SnackBar(content: Text('Id ou mot  de passe vides'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

  }
}
