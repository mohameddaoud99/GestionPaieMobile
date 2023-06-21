import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../menu/drawer.widget.dart';

class CongeacceptePage extends StatefulWidget {
  @override
  _CongeacceptePageState createState() => _CongeacceptePageState();
}

class _CongeacceptePageState extends State<CongeacceptePage> {
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
        'https://localhost:44367/api/MajCoge/GetCongesAccepterByIdE?matricule=${prefs.getString('MATREmployee')}');

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
          .where((conge) =>
              conge['libelle'].toLowerCase().contains(type.toLowerCase()) ||
              conge['type'].toLowerCase().contains(type.toLowerCase()) ||
              conge['datedepart'].contains(type.toLowerCase()))
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
        title: Text("Liste des congés acceptés"),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Recherche par type de congé",
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
                          "Aucun congé ne correspond à votre recherche.",
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
                                    conge['libelle'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Nombre de jours: ${conge['nbrjour']}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    'Date de départ: ${conge['datedepart']}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    'Date de fin: ${conge['datefin']}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    'Type: ${conge['type']}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
          ),
        )
      ]),
    );
  }
}
