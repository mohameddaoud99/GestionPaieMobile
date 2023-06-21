import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'package:http/http.dart' as http;

import '../model/TypeConge.dart';

class ModifConge extends StatefulWidget {
  final String id_User;
  final String datedepart;
  final String datefin;
  final String description;

  ModifConge(this.id_User, this.datedepart, this.datefin, this.description);

  @override
  _ModifCongeState createState() => _ModifCongeState();
}

class _ModifCongeState extends State<ModifConge> {
  TextEditingController _typeController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _txtId_User = TextEditingController();
  TextEditingController _textdatedepart = TextEditingController();
  TextEditingController _txtdatefin = TextEditingController();
  TextEditingController _txtdescription = TextEditingController();
  DateTime? _selectedDate;
  late String sl;
  List<DropdownMenuItem<TypeConge>> _items = [];
  TypeConge? _selectedItem;

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
      throw Exception('Failed to'
          ''
          ''
          ' load options');
    }
  }

  void initState() {
    super.initState();
    setState(() {
      _getItems();

      _txtId_User.text = widget.id_User;
      _textdatedepart.text = DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(widget.datedepart.toString()));
      _txtdatefin.text = DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(widget.datefin.toString()));
      _txtdescription.text = widget.description;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier Conge'),
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<TypeConge>(
                decoration: InputDecoration(
                  labelText: 'Type Congé',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.eggPlant, width: 1.5),
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.eggPlant, width: 1.5),
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
                    print(value!.code.toString());
                    sl = value!.libelle.toString();
                    _codeController.text = value!.code.toString();
                    _typeController.text = value!.type.toString();
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onTap: () async {
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
                      _txtdatefin.text = DateFormat('yyyy-MM-dd').format(
                          DateTime.parse(_selectedDate
                              .toString())); // update the TextFormField value
                    });
                  }
                },
                controller: _txtdatefin,
                decoration: InputDecoration(
                  labelText: 'Date Fin',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.eggPlant, width: 1.5),
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.eggPlant, width: 1.5),
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
                controller: _txtdescription,
                decoration: InputDecoration(
                  labelText: 'Description',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.eggPlant, width: 1.5),
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.eggPlant, width: 1.5),
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
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () {
                  submitForm();
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
      ),
    );
  }

  String convertDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  Widget buildDateTimePicker(String data) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(color: AppColors.eggPlant, width: 1.5),
      ),
      title: Text(data),
      trailing: const Icon(
        Icons.date_range,
        color: AppColors.eggPlant,
      ),
    );
  }

  Widget buildTextField(
      {String? hint, required TextEditingController controller}) {
    return TextField(
      minLines: 1,
      maxLines: null,
      controller: controller,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: hint ?? '',
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.eggPlant, width: 1.5),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.eggPlant, width: 1.5),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
      ),
    );
  }

  late SharedPreferences prefs;
  void submitForm() async {
    final url = Uri.parse('https://localhost:44367/api/MajConge?datedepart=' +
        DateFormat('yyyy-MM-d').format(DateTime.parse(_textdatedepart.text)));

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'accept': 'application/json'
    };
    prefs = await SharedPreferences.getInstance();
    prefs.getString('MATREmployee');

    final body = {
      'code': _codeController.text,
      'type': _typeController.text,
      'libelle': sl.toString(),
      'matricule': prefs.getString('MATREmployee'),
      'nomprenom': prefs.getString('NOMPRENOM1Employee'),
      'datefin':
          DateFormat('yyyy-MM-d').format(DateTime.parse(_txtdatefin.text)) +
              "T00:00:00",
      'description': _txtdescription.text,
    };

    final response =
        await http.put(url, body: jsonEncode(body), headers: headers);

    final responseData = json.decode(response.body);
    print(response.body.toString());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Conge modifier avec success'),
      duration: Duration(seconds: 2),
    ));

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
