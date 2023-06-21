import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/TypeConge.dart';

class AjoutModifCongenattentePage extends StatefulWidget {
  @override
  _AjoutModifCongenattentePageState createState() =>
      _AjoutModifCongenattentePageState();
}

class _AjoutModifCongenattentePageState
    extends State<AjoutModifCongenattentePage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime? _selectedDate;
  TextEditingController _codeController = TextEditingController();
  TextEditingController _datedepartController = TextEditingController();
  TextEditingController _datefinController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  late String sl;
  List<DropdownMenuItem<TypeConge>> _items = [];
  TypeConge? _selectedItem;

  @override
  void initState() {
    super.initState();
    _getItems();
  }

  Future<void> _getItems() async {
    await http.get(
        Uri.parse('https://localhost:44367/api/ChoixBD?dbName=grpaie2'),
        headers: {'Access-Control-Allow-Origin': '*'});
    var response = await http
        .get(Uri.parse('https://localhost:44367/api/TypeCoge/GetTypeCoge'));
    print(response.body);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      setState(() {
        _items = (json as List).map((data) {
          return DropdownMenuItem<TypeConge>(
            child: Text(data['libelle']),
            value: TypeConge.fromJson(data),
          );
        }).toList();
      });
    } else {
      throw Exception('Failed to load options');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Ajouter Conge'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<TypeConge>(
              decoration: InputDecoration(
                labelText: 'Type Congé',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.eggPlant, width: 1.5),
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.eggPlant, width: 1.5),
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                ),
              ),
              value: _selectedItem,
              items: _items,
              hint: const Text('Select an Type conge'),
              onChanged: (value) {
                setState(() {
                  _selectedItem = value;
                });
                print(value!.code.toString());
                sl = value!.libelle.toString();
                _codeController.text = value!.code.toString();
                _typeController.text = value!.type.toString();
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _typeController,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Enter your text',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Visibility(
              visible: false,
              child: TextFormField(
                controller: _codeController,
                decoration: InputDecoration(labelText: 'Code'),
                enabled: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Code is required';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              onTap: () async {
                // Show the datepicker and get the user's selected date
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate ??
                      DateTime.now(), // set initial date if exists
                  firstDate:
                      DateTime(2015, 8), // set the earliest possible date
                  lastDate: DateTime(2101), // set the latest possible date
                );

                // Update the selected date in the state
                if (picked != null && picked != _selectedDate) {
                  setState(() {
                    _selectedDate = picked;
                    _datedepartController.text = DateFormat('yyyy-MM-dd')
                        .format(DateTime.parse(_selectedDate
                            .toString())); // update the TextFormField value
                  });
                }
              },
              controller: _datedepartController,
              decoration: InputDecoration(
                labelText: 'Date départ',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.eggPlant, width: 1.5),
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.eggPlant, width: 1.5),
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Datedepart is required';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onTap: () async {
                // Show the datepicker and get the user's selected date
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate ??
                      DateTime.now(), // set initial date if exists
                  firstDate:
                      DateTime(2015, 8), // set the earliest possible date
                  lastDate: DateTime(2101), // set the latest possible date
                );

                // Update the selected date in the state
                if (picked != null && picked != _selectedDate) {
                  setState(() {
                    _selectedDate = picked;
                    _datefinController.text = DateFormat('yyyy-MM-dd').format(
                        DateTime.parse(_selectedDate
                            .toString())); // update the TextFormField value
                  });
                }
              },
              controller: _datefinController,
              decoration: InputDecoration(
                labelText: 'Date Fin',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.eggPlant, width: 1.5),
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.eggPlant, width: 1.5),
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'datefin is required';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.eggPlant, width: 1.5),
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.eggPlant, width: 1.5),
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Description is required';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  submitForm();
                }
              },
              child: const Text('Valider', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  late SharedPreferences prefs;
  void submitForm() async {
    final url = Uri.parse('https://localhost:44367/api/majconge');

    // final headers = 'Access-Control-Allow-Origin': '*',   };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'accept': 'application/json'
    };
    prefs = await SharedPreferences.getInstance();
    prefs.getString('MATREmployee');
    //print(prefs.getString('MATREmployee'));
    //print(prefs.getString('MATREmployee'));

    final body = {
      'code': _codeController.text,
      'libelle': sl.toString(),
      'datedepart': DateFormat('yyyy-MM-d')
              .format(DateTime.parse(_datedepartController.text)) +
          "T00:00:00",
      'datefin': DateFormat('yyyy-MM-d')
              .format(DateTime.parse(_datefinController.text)) +
          "T00:00:00",
      'description': _descriptionController.text,
      'matricule': prefs.getString('MATREmployee'),
      'nomprenom': prefs.getString('NOMPRENOM1Employee'),
      'type': _typeController.text,
    };
    print(body);

    final response =
        await http.post(url, body: jsonEncode(body), headers: headers);

    final responseData = json.decode(response.body);
    print(response.body.toString());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Ajouter avec a'),
      duration: Duration(seconds: 2),
    ));

   // Navigator.pushNamed(context, "/contact");

    Navigator.pushNamed(context, "/Congenattente");
  }
}

class AppColors {
  AppColors._();

  static const Color blackCoffee = Color(0xff7985d0);
  static const Color eggPlant = Color(0xff7985d0); //0xff2196f3
  static const Color celeste = Color(0xFFb1ede8);
  static const Color babyPowder = Color(0xFFFFFcF9);
  static const Color ultraRed = Color(0xFFFF6978);
}
