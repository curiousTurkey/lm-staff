import 'package:flutter/material.dart';
import 'package:lms_staff/ReusableUtils/Colors.dart' as color_mode;
import 'package:lms_staff/ReusableUtils/Responsive.dart' as resize;

Widget alertDialog({required String title,
  required VoidCallback onPressed,
  required String button1,
  required String button2,
  required BuildContext context}){
  return AlertDialog(
    backgroundColor: color_mode.primaryColor,
    elevation: 20,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30)
    ),
    title: Text(title,
      style: TextStyle(
        color:  color_mode.unImportant,
        fontSize: resize.screenLayout(25, context),
        fontWeight: FontWeight.w700,
      ),
    ),
    actions: [
      TextButton(onPressed: (){Navigator.pop(context);}, child: Text(button1,
        style: TextStyle(
            color: color_mode.secondaryColor2,
            fontWeight: FontWeight.w500
        ),
      ),),
      TextButton(onPressed: ()async{
        onPressed();
      }, child: Text(button2,
        style: TextStyle(
            color: color_mode.secondaryColor2,
            fontWeight: FontWeight.w500
        ),
      ),)
    ],
  );
}