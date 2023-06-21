import 'package:flutter/material.dart';

Widget Cader2(String title, String spots, icon, String img) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Container(
      decoration: BoxDecoration(
        //  color: Color(0xFFE2B9E8),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Icon(icon, size: 25,color: Color(0xFFCE93D8), ),
            FloatingActionButton.small(
              backgroundColor: Color(0xFFCE93D8),
              heroTag: "btn2",
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