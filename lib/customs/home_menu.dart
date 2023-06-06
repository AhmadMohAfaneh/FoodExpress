 import 'package:e_commerce/consts/consts.dart';
import 'package:flutter/material.dart';

 Widget homeMenu() {
   return Column(
     children: [
       ClipRRect(
         borderRadius: BorderRadius.circular(20),
         child: Container(
           height: 90,
           width: 140,
           color: Colors.transparent, // Set the color to transparent
           child: Image.asset(
             imgBurgersMenu,
             fit: BoxFit.cover,
           ),
         ),
       ),
       const SizedBox(height: 5),
       const Text(
         "burgers",
         style: TextStyle(fontFamily: semibold, color: Colors.black,fontSize: 18),
       ),
     ],
   );
 }

