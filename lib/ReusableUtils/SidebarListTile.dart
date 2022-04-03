import 'package:flutter/material.dart';
import 'package:lms_staff/ReusableUtils/Colors.dart' as color_mode;

Widget sidebarListTile({
  required String title,

  required IconData leadingIcon,
  required VoidCallback onTap,
}){
  return ListTile(
    leading: Icon(
      leadingIcon, color: color_mode.secondaryColor,),
    title: Text(title),
    textColor: color_mode.tertiaryColor,
    trailing: Icon(Icons.arrow_forward_ios_rounded,
      color: color_mode.tertiaryColor,),
    enableFeedback: true,
    onTap: onTap,
  );
}