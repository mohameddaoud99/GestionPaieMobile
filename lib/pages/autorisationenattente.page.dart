import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../menu/drawer.widget.dart';
import 'ajouter_autorisation.dart';
import 'modifier_autorisation.dart';

class AutorisationenattentePage extends StatefulWidget {
  @override
  _AutorisationenattentePageState createState() =>
      _AutorisationenattentePageState();
}

class _AutorisationenattentePageState extends State<AutorisationenattentePage> {
  final LocalStorage storage = new LocalStorage('localstorage_app');

  List<Map<String, dynamic>> _listConge = [];
  List<Map<String, dynamic>> _filteredListConge = [];
  bool _isLoading = true;
  late SharedPreferences prefs;

  Future<void> _fetchListConge() async {
    prefs = await SharedPreferences.getInstance();
    prefs.getString('MATREmployee');
    print(prefs.getString('MATREmployee'));

    final url = Uri.parse(
        'https://localhost:44367/api/Autorisation/GetAutorisationByUser?matricule=${prefs.getString('MATREmployee')}&nomprenom=${prefs.getString('NOMPRENOM1Employee')}');

    final response = await http.get(url);
    final data = json.decode(response.body);

    print(data);

    final List<Map<String, dynamic>> loadedList = [];

    for (var item in data) {
      loadedList.add(item);
    }

    setState(() {
      _listConge = loadedList;
      _filteredListConge = loadedList;
      _isLoading = false;
    });
  }

  void _filterByType(String type) {
    setState(() {
      _filteredListConge = _listConge
          .where((conge) => conge['date'].contains(type.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchListConge();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Liste des Autorisation en attante"),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Recherche par date de Autorisation",
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              suffixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              _filterByType(value);
            },
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : _filteredListConge.isEmpty
                    ? Center(
                        child: Text(
                          "Aucun autorisation ne correspond à votre recherche.",
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _filteredListConge.length,
                        itemBuilder: (ctx, index) {
                          final conge = _filteredListConge[index];
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    conge['date'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Nombre de jours: ${conge['nbrheure']}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    'Description: ${conge['description']}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Supprimer autorisation'),
                                                content: Text(
                                                    'Voulez-vous vraiment supprimer cet autorisation ?'),
                                                actions: [
                                                  TextButton(
                                                    child: Text('Annuler'),
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                  ),
                                                  TextButton(
                                                    child: Text('Supprimer'),
                                                    onPressed: () async {
                                                      await _deleteConge(
                                                          conge['matricule'],
                                                          conge['nomprenom'],
                                                          conge['date']);
                                                      setState(() {
                                                        _listConge
                                                            .remove(conge);
                                                        _filteredListConge
                                                            .remove(conge);
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.edit,
                                            color: Colors.green),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ModifAutorisation(
                                                      conge['nbrheure'],
                                                      conge['date'],
                                                      conge['description']),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
          ),
        )
      ]),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.menu), onPressed: () {}),
            Spacer(),
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
            IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AjoutAutorisationPage(),
                ));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future<void> _deleteConge(
      String matricule, String nomprenom, String date) async {
    final url = Uri.parse(
        'https://localhost:44367/api/Autorisation/DeleteMajCogeUtilisateur?matricule=$matricule&nomprenom=$nomprenom&date=$date');

    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        print('Autorisation supprimé avec succès');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Autorisation supprimé avec succès'),
          duration: Duration(seconds: 2),
        ));
      } else {
        print('Erreur lors de la suppression du autorisation');
      }
    } catch (error) {
      print('Erreur lors de la suppression du autorisation: $error');
    }
  }
}
