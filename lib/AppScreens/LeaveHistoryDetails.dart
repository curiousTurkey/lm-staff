import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lms_staff/ReusableUtils/Appbar.dart';
import 'package:lms_staff/ReusableUtils/Responsive.dart';
import 'package:lms_staff/Staff%20Provider/StaffProvider.dart';
import 'package:provider/provider.dart';
import '../Models/LeaveModel.dart';
import '../Models/StaffModel.dart';
import 'package:lms_staff/ReusableUtils/Colors.dart' as color_mode;
import 'package:lms_staff/ReusableUtils/Responsive.dart' as resize;

import '../ReusableUtils/HeightWidth.dart';

class LeaveHistoryDetails extends StatefulWidget {
  final String docId;
  const LeaveHistoryDetails({Key? key,
    required this.docId
  }) : super(key: key);

  @override
  State<LeaveHistoryDetails> createState() => _LeaveHistoryDetailsState();
}

class _LeaveHistoryDetailsState extends State<LeaveHistoryDetails> {
  @override
  Widget build(BuildContext context) {
    StaffModel staffModel = Provider.of<StaffProvider>(context).getStaff;
    TextStyle textStyle = TextStyle(
      color: color_mode.secondaryColor,
      fontSize: resize.screenLayout(30, context),
      fontWeight: FontWeight.w800,
    );
    final Future<DocumentSnapshot<Map<String, dynamic>>> leaveDetails = FirebaseFirestore.instance.collection('leave').doc(widget.docId).get();
    return Scaffold(
        appBar: appBar(context: context, title: 'Title'),
        body: FutureBuilder(
            future: leaveDetails,
            builder: (_, AsyncSnapshot<DocumentSnapshot> snapshot){
              if (snapshot.hasError) {
                return const Text('Something went wrong. Try again later.');
              }
              else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: SpinKitFoldingCube(
                  color: color_mode.secondaryColor,
                  size: resize.screenLayout(80, context),
                  duration: const Duration(milliseconds: 1500),
                ));
              }
              StaffLeaveModel leaveModel = StaffLeaveModel.fromJsonAsync(snapshot as AsyncSnapshot<DocumentSnapshot<Map<String , dynamic>>>);
              return SingleChildScrollView(
                child: Container(
                  width: getWidth(context),
                  height: getHeight(context),
                  decoration: BoxDecoration(
                      color: color_mode.primaryColor
                  ),
                  child: Column(
                      children: [
                        resize.verticalSpace(80, context),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            resize.horizontalSpace(60, context),
                            Text('Name :',
                                style: textStyle),
                            resize.horizontalSpace(20, context),
                            Text(leaveModel.fullName,
                                style: textStyle
                            ),
                          ],
                        ),
                        resize.verticalSpace(50, context),
                        Row(
                          children: [
                            resize.horizontalSpace(60, context),
                            Text('E-mail : ',
                              style: textStyle,
                            ),
                            resize.horizontalSpace(20, context),
                            Text(leaveModel.emailAddress,
                              style: textStyle,)
                          ],
                        ),
                        resize.verticalSpace(50, context),
                        Row(
                          children: [
                            resize.horizontalSpace(60, context),
                            Text('Leave Subject : ',
                              style: textStyle,
                            ),
                            resize.horizontalSpace(20, context),
                            LimitedBox(
                              maxWidth: resize.screenLayout(240, context),
                              child: Text(leaveModel.leaveSubject,
                                style: textStyle,),
                            )
                          ],
                        ),
                        resize.verticalSpace(50, context),
                        Row(
                          children: [
                            resize.horizontalSpace(60, context),
                            Text('Leave Reason : ',
                              style: textStyle,
                            ),
                            resize.horizontalSpace(20, context),
                            LimitedBox(
                              maxWidth: resize.screenLayout(240, context),
                              child: Text(leaveModel.leaveReason,
                                style: textStyle,),
                            )
                          ],
                        ),
                        resize.verticalSpace(50, context),
                        Row(
                          children: [
                            resize.horizontalSpace(60, context),
                            Text('Department : ',
                              style: textStyle,
                            ),
                            resize.horizontalSpace(20, context),
                            Text(leaveModel.dept,
                              style: textStyle,)
                          ],
                        ),
                        resize.verticalSpace(50, context),
                        Row(
                          children: [
                            resize.horizontalSpace(60, context),
                            Text('From Date : ',
                              style: textStyle,
                            ),
                            resize.horizontalSpace(20, context),
                            Text(DateTime.parse(leaveModel.fromDate).toString(),
                              style: textStyle,)
                          ],
                        ),
                        resize.verticalSpace(50, context),
                        Row(
                          children: [
                            resize.horizontalSpace(60, context),
                            Text('To Date : ',
                              style: textStyle,
                            ),
                            resize.horizontalSpace(20, context),
                            Text(DateTime.parse(leaveModel.toDate).toString(),
                              style: textStyle,)
                          ],
                        ),
                        resize.verticalSpace(50, context),
                        Row(
                          children: [
                            resize.horizontalSpace(60, context),
                            Text('From Session : ',
                              style: textStyle,
                            ),
                            resize.horizontalSpace(20, context),
                            Text(leaveModel.session1,
                              style: textStyle,)
                          ],
                        ),
                        resize.verticalSpace(50, context),
                        Row(
                          children: [
                            resize.horizontalSpace(60, context),
                            Text('To Session : ',
                              style: textStyle,
                            ),
                            resize.horizontalSpace(20, context),
                            Text(leaveModel.session2,
                              style: textStyle,)
                          ],
                        ),
                        resize.verticalSpace(50, context),
                      ]
                  ),
                ),
              );
            })
    );
  }
}
