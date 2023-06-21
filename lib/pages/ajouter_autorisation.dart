import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AjoutAutorisationPage extends StatefulWidget {
  @override
  _AjoutAutorisationState createState() => _AjoutAutorisationState();
}

class _AjoutAutorisationState extends State<AjoutAutorisationPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime? _selectedDate;
  TextEditingController _nbrheureController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Add Autorisation'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
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
                    _dateController.text = DateFormat('yyyy-MM-dd').format(
                        DateTime.parse(_selectedDate
                            .toString())); // update the TextFormField value
                  });
                }
              },
              controller: _dateController,
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
                  return 'Date is required';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _nbrheureController,
              decoration: InputDecoration(
                labelText: 'Nombre Heure',
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
    final url = Uri.parse('https://localhost:44367/api/Autorisation');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'accept': 'application/json'
    };
    prefs = await SharedPreferences.getInstance();
    prefs.getString('MATREmployee');

    final body = {
      'nbrheure': _nbrheureController.text,
      'date':
          DateFormat('yyyy-MM-d').format(DateTime.parse(_dateController.text)) +
              "T00:00:00",
      'description': _descriptionController.text,
      'matricule': prefs.getString('MATREmployee'),
      'nomprenom': prefs.getString('NOMPRENOM1Employee'),
    };
    print(body);

    final response =
        await http.post(url, body: jsonEncode(body), headers: headers);

    final responseData = json.decode(response.body);
    print(response.body.toString());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Autorisation added successfully.'),
      duration: Duration(seconds: 2),
    ));

    Navigator.pushNamed(context, "/autorisationenattente");
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
