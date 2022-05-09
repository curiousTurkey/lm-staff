import 'package:flutter/material.dart';
import 'package:lms_staff/AppScreens/TimeTableDetails.dart';
import 'package:lms_staff/Models/StaffModel.dart';
import 'package:lms_staff/ReusableUtils/Appbar.dart';
import 'package:lms_staff/ReusableUtils/Colors.dart' as color_mode;
import 'package:lms_staff/ReusableUtils/ListTile.dart';
import 'package:lms_staff/ReusableUtils/Responsive.dart' as resize;
import 'package:provider/provider.dart';

import '../Staff Provider/StaffProvider.dart';

class ViewTimeTable extends StatefulWidget {
  const ViewTimeTable({Key? key}) : super(key: key);

  @override
  State<ViewTimeTable> createState() => _ViewTimeTableState();
}

class _ViewTimeTableState extends State<ViewTimeTable> {

  void navigateToTimeTable ({
  required String docId,
}) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => TimeTableDetails(docId: docId)));
  }
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      color: color_mode.secondaryColor,
      fontSize: resize.screenLayout(30, context),
      fontWeight: FontWeight.w800,

    );
    StaffModel userModel = Provider.of<StaffProvider>(context).getStaff;
    return Scaffold(
      appBar: appBar(context: context, title: 'TimeTable'),
      body: ListView(
        children: [
          listTile(onTap: () => navigateToTimeTable(docId: '1st Sem'), title: 'Semester 1', context: context),
          listTile(onTap: () => navigateToTimeTable(docId: '2nd Sem'), title: 'Semester 2', context: context),
          listTile(onTap: () => navigateToTimeTable(docId: '3rd Sem'), title: 'Semester 3', context: context),
          listTile(onTap: () => navigateToTimeTable(docId: '4th Sem'), title: 'Semester 4', context: context),
          listTile(onTap: () => navigateToTimeTable(docId: '5th Sem'), title: 'Semester 5', context: context),
          listTile(onTap: () => navigateToTimeTable(docId: '6th Sem'), title: 'Semester 6', context: context),
        ],
      ),
    );
  }
}
