import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'package:http/http.dart' as http;

class ModifAutorisation extends StatefulWidget {
  final int nbrheure;
  final String datedepart;
  final String description;

  ModifAutorisation(this.nbrheure, this.datedepart, this.description);

  @override
  _ModifAutorisationState createState() => _ModifAutorisationState();
}

class _ModifAutorisationState extends State<ModifAutorisation> {
  TextEditingController _nbrheureController = TextEditingController();

  TextEditingController _textdatedepart = TextEditingController();

  TextEditingController _txtdescription = TextEditingController();
  DateTime? _selectedDate;

  void initState() {
    super.initState();
    setState(() {
      _nbrheureController.text = widget.nbrheure.toString();
      _textdatedepart.text = DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(widget.datedepart.toString()));
      _txtdescription.text = widget.description;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier Autorisation'),
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      _textdatedepart.text = DateFormat('yyyy-MM-dd').format(
                          DateTime.parse(_selectedDate
                              .toString())); // update the TextFormField value
                    });
                  }
                },
                controller: _textdatedepart,
                decoration: InputDecoration(
                  labelText: 'Date départ',
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
                    return 'Date is required';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _nbrheureController,
                decoration: InputDecoration(
                  labelText: 'Nombre Heur',
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
                    return 'Nombre Heur is required';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
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
    final url = Uri.parse('https://localhost:44367/api/Autorisation?date=' +
        DateFormat('yyyy-MM-d').format(DateTime.parse(_textdatedepart.text)));

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'accept': 'application/json'
    };
    prefs = await SharedPreferences.getInstance();
    prefs.getString('MATREmployee');

    final body = {
      'date':
          DateFormat('yyyy-MM-d').format(DateTime.parse(_textdatedepart.text)) +
              "T00:00:00",
      'nbrheure': _nbrheureController.text,
      'matricule': prefs.getString('MATREmployee'),
      'nomprenom': prefs.getString('NOMPRENOM1Employee'),
      'description': _txtdescription.text,
    };

    final response =
        await http.put(url, body: jsonEncode(body), headers: headers);

    final responseData = json.decode(response.body);
    print(response.body.toString());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Autorisation modifier avec success'),
      duration: Duration(seconds: 2),
    ));

  //  Navigator.pushNamed(context, "/gallerie");
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
