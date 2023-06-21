import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voyage/pages/Cader1.dart';
import 'package:voyage/pages/Cader2.dart';
import 'package:voyage/pages/Cader3.dart';
import 'package:voyage/pages/Cader4.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return
       Center(

    child: GridView.count(

        crossAxisCount: 2,
          children: <Widget>[

            Column(
                children: <Widget>[
                  Container(
                      height: 155.0,
                      width: MediaQuery.of(context).size.width*.5,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Cader1('Expiration dans 16 jours', 'September 14, 2016', Icons.cancel_presentation, 'carousel_01')
                      )),
                ]
            ),
            Column(
                children: <Widget>[
                  Container(
                      height: 155.0,
                      width: MediaQuery.of(context).size.width*.5,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Cader2('68 Documents consultés', '44 avec ce compte', Icons.list_alt, 'carousel_02'),
                      )),
                ]
            ),

            Column(
                children: <Widget>[
                  Container(
                      height: 155.0,
                      width: MediaQuery.of(context).size.width*.5,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Cader1('Expiration dans 16 jours', 'September 14, 2016', Icons.cancel_presentation, 'carousel_01')
                      )),
                ]
            ),
            Column(
                children: <Widget>[
                  Container(
                      height: 155.0,
                      width: MediaQuery.of(context).size.width*.5,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Cader2('68 Documents consultés', '44 avec ce compte', Icons.list_alt, 'carousel_02'),
                      )),
                ]
            ),

            Column(
                children: <Widget>[
                  Container(
                      height: 155.0,
                      width: MediaQuery.of(context).size.width*.5,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Cader1('Expiration dans 16 jours', 'September 14, 2016', Icons.cancel_presentation, 'carousel_01')
                      )),
                ]
            ),
            Column(
                children: <Widget>[
                  Container(
                      height: 155.0,
                      width: MediaQuery.of(context).size.width*.5,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Cader2('68 Documents consultés', '44 avec ce compte', Icons.list_alt, 'carousel_02'),
                      )),
                ]
            ),

            Column(
                children: <Widget>[
                  Container(
                      height: 155.0,
                      width: MediaQuery.of(context).size.width*.5,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Cader1('Expiration dans 16 jours', 'September 14, 2016', Icons.cancel_presentation, 'carousel_01')
                      )),
                ]
            ),
            Column(
                children: <Widget>[
                  Container(
                      height: 155.0,
                      width: MediaQuery.of(context).size.width*.5,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Cader2('68 Documents consultés', '44 avec ce compte', Icons.list_alt, 'carousel_02'),
                      )),
                ]
            )
          ],



        //ListView

    ),
    );
  }

}