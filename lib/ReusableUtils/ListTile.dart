import 'package:flutter/material.dart';
import 'package:lms_staff/ReusableUtils/Responsive.dart';

Widget listTile({
  required VoidCallback onTap,
  required String title,
  required BuildContext context
}) {
  return ListTile(
  minVerticalPadding: screenLayout(50, context),
  title: Text(title),
  onTap: onTap,
  );
}