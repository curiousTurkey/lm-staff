import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lms_staff/ReusableUtils/Colors.dart' as color_mode;
import 'package:lms_staff/ReusableUtils/Responsive.dart';

  InkWell homeContainer({
    required BuildContext context,
    required String description,
    required String heading,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              screenLayout(30, context))),
      splashColor: color_mode.secondaryColor2.withOpacity(1),
      onTap: onTap,
      child: Container(
          height: screenLayout(270, context),
          width: screenLayout(320, context),
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: color_mode.spclColor.withOpacity(.5))],
            borderRadius: BorderRadius.circular(
                screenLayout(30, context)),
            color: color_mode.primaryColor.withOpacity(.5),
          ),
          child: Padding(
            padding: EdgeInsets.all(screenLayout(25,context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FaIcon(icon,color: color_mode.secondaryColor2,size: screenLayout(73, context),),
                Text(heading,
                  style: TextStyle(
                    fontSize: screenLayout(25,context),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                    color: color_mode.tertiaryColor,
                  ),
                ),

                Text(description,
                  style: TextStyle(
                    fontSize: screenLayout(20,context),
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1.1,
                    color: color_mode.unImportant,
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }

