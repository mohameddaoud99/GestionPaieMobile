import 'package:flutter/material.dart';

Widget Cader3(String title, String spots, icon, String img) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Container(
      decoration: BoxDecoration(
        //color: Colors.black,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //  Icon(icon, size: 25, ),
            FloatingActionButton.small(
              heroTag: "btn3",
              backgroundColor: Color(0xFF9FA8DA),
              onPressed: () {},
              child: Icon(
                icon,
                size: 28,
                color: Colors.white,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,),
                SizedBox(height: 5,),
                Text(spots, style: TextStyle( color: Colors.black.withOpacity(0.6)))
              ],),
          ],
        ),
      ),
    ),
  );
}