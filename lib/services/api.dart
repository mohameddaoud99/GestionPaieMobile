import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Api extends ChangeNotifier {

  static  getAll() async{
    String Url ="http://localhost:5125/api/Interventions";
    var response = await http.get(Uri.parse(Url));
    if (response.statusCode == 200){
      var body = jsonDecode(response.body);
      return body;
    }else{
      throw Exception( ("errer"));
    }
  }

  static Future<Response> deleteIntervention(String id) async{

    const uri ='http://localhost:5125/api/Interventions/';
    String t = '$id';
    final Response response = await http.delete(Uri.parse('$uri$t'));
    print(id);
    if(response.statusCode == 200){

      return response;

    }else{
      throw Exception("can't load author");
    }
  }

  static Future<Response> ModifIntervention (String id,String Id_User,String StartTime, String EndTime, String Description) async{
    var unintervention ={
      "id":id,
      "id_User" : Id_User,
      "startTime" : StartTime,
      "endTime" : EndTime,
      "description" : Description,
    };
    Map<String,String> headers = {'Content-Type':'application/json','accept' : 'application/json'};
    String t = '$id';
    const uri ='http://localhost:5125/api/Interventions/';
    final Response response = await http.put(Uri.parse('$uri$t'),headers: headers,body: jsonEncode(unintervention),);
    if(response.statusCode == 200){
      print(response.body.toString());
      return response;
    }else{
      throw Exception("can't load author");
    }
  }


  static Future<Response> addIntervention (unintervention) async{
    print(unintervention);
    Map<String,String> headers = {'Content-Type':'application/json','accept' : 'application/json'};
    const uri ='http://localhost:5125/api/Interventions/';
    final Response response = await http.post(Uri.parse(uri),headers: headers,body: jsonEncode(unintervention),);
    if(response.statusCode == 200){
      print(response.body.toString());
      return response;
    }else{
      throw Exception("can't load author");
    }
  }



}
