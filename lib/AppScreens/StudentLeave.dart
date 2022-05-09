import 'package:flutter/material.dart';
import 'package:lms_staff/ReusableUtils/Appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
import '../ReusableUtils/SnackBar.dart';
class StudentLeave extends StatefulWidget {
  const StudentLeave({Key? key}) : super(key: key);

  @override
  State<StudentLeave> createState() => _StudentLeaveState();
}

class _StudentLeaveState extends State<StudentLeave> {
  @override
  Widget build(BuildContext context) {
    StaffModel staffModel = Provider.of<StaffProvider>(context).getStaff;
    final Stream<QuerySnapshot> leaveApplicants = FirebaseFirestore.instance.collection('student leave').
    where('isapproved',isEqualTo: 'no').
    where("semester", isEqualTo: staffModel.semClassTeacher).snapshots();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: color_mode.secondaryColor,
        title: Text('Leave Applicants',
          style: TextStyle(
              color: color_mode.primaryColor,
              fontSize: resize.screenLayout(30, context)
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: leaveApplicants,
          builder: (_,AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong. Try again later.'));
            }
            else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: SpinKitFoldingCube(
                color: color_mode.secondaryColor,
                size: resize.screenLayout(80, context),
                duration: const Duration(milliseconds: 1500),
              ));
            }
            final data = snapshot.requireData;
            final length = snapshot.data!.size;
            return ListView.builder(
              itemCount: length,
              itemBuilder: (BuildContext context, int index) {
                String name = snapshot.data!.docs[index]["name"];
                String dept = snapshot.data!.docs[index]["deptName"];
                String session2 = snapshot.data!.docs[index]["session2"];
                String fromDate = snapshot.data!.docs[index]["fromdate"];
                String toDate = snapshot.data!.docs[index]["todate"];
                String email = snapshot.data!.docs[index]["email"];
                String leaveReason = snapshot.data!.docs[index]["leavereason"];
                String session1 = snapshot.data!.docs[index]["session1"];
                String leavesub = snapshot.data!.docs[index]["leavesub"];
                String semester = snapshot.data!.docs[index]['semester'];
                String userId = snapshot.data!.docs[index]['userid'];
                String docId = snapshot.data!.docs[index].id;
                return ListTile(
                  minVerticalPadding: resize.screenLayout(20, context),
                  title: Text(name),
                  onTap: () => navigateToDetail(
                      name,
                      dept,
                      session2,
                      session1,
                      fromDate,
                      toDate,
                      email,
                      leaveReason,
                      leavesub,
                      docId,
                      semester,
                      userId
                  ),
                );
              },
            );
          }
      ),
    );
  }
  navigateToDetail(String name,
      String dept,
      String session2,
      String session1,
      String fromDate,
      String toDate,
      String email,
      String leaveReason,
      String leavesub,
      String docId,
      String semester,
      String userId
      ) {
    int days ;
    DateTime parseFromDate = DateTime.parse(fromDate);
    DateTime parseToDate = DateTime.parse(toDate);
    days = parseToDate.difference(parseFromDate).inDays;
    Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(
        name: name,
        dept: dept,
        session2: session2,
        fromDate: fromDate,
        toDate: toDate,
        email: email,
        leavereason: leaveReason,
        session1: session1,
        leavesub: leavesub,
        days: days,
        docId : docId,
        semester : semester,
        userId : userId,

    )));
  }
}

class DetailPage extends StatefulWidget {
  final String name;
  final String email;
  final String leavereason;
  final String leavesub;
  final String session1;
  final String session2;
  final String fromDate;
  final String toDate;
  final String dept;
  final int days ;
  final String docId;
  final String semester;
  final String userId;
  const DetailPage({
    Key? key,
    required this.userId,
    required this.name,
    required this.email,
    required this.leavereason,
    required this.leavesub,
    required this.session1,
    required this.session2,
    required this.fromDate,
    required this.toDate,
    required this.dept,
    required this.days,
    required this.docId,
    required this.semester,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late double totalDays;
  @override
  void initState(){
    super.initState();
    dayCalculation();
  }
  void dayCalculation(){
    double requestedDays ;
    if(widget.fromDate == widget.toDate && widget.session1 == widget.session2) {
      requestedDays = widget.days.toDouble() + 0.5;
    }
    else if(widget.fromDate == widget.toDate && widget.session1 != widget.session2){
      requestedDays = widget.days.toDouble() + 1.0;
    }
    else if(widget.fromDate != widget.toDate && widget.session1 == widget.session2){
      requestedDays = widget.days.toDouble() + 0.5;
    }
    else{
      requestedDays = widget.days.toDouble() + 1.0;
    }
    totalDays = requestedDays;
  }
  //leave approval
  Future<String> leaveApproved(String email,int days, String session1, String session2,String fromDate, String toDate) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String finalResult = "Some error occurred. Please check network connection or try again later.";
    try {

      await FirebaseFirestore.instance.collection('student leave').doc(widget.docId).update({"isapproved" : 'yes'});
      DocumentSnapshot snapshot = await firestore.collection('users').doc(widget.userId).get(); //to get the casual leave taken from user document.
      finalResult = "success";
      if(finalResult == "success"){
        double casual = (snapshot.data() as Map<String,dynamic>)['leavetaken']; //getting number of casual leave from user document.
        double requestedDays = totalDays + casual;
        await firestore.collection('users').doc(email).update({'leavetaken' : requestedDays });
      }
      snackBar(content: 'Leave application approved successfully.', duration: 1500, context: context);
      return finalResult;
    } catch(error){
      return finalResult = error.toString();
    }
  }
  Future<String> leaveRejected(String email) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String finalResult = "Some error occurred. Please check network connection or try again later.";
    try {
      await firestore.collection('student leave').doc(widget.docId).update(
          {"isapproved" : 'Rejected'});
      finalResult = "success";
      return finalResult;
    } catch(error){
      return finalResult = error.toString();
    }
  }
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      color: color_mode.secondaryColor,
      fontSize: resize.screenLayout(30, context),
      fontWeight: FontWeight.w800,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: color_mode.secondaryColor,
        title: Text('Leave Applicant Details',
            style: TextStyle(
              color: color_mode.primaryColor,
              fontSize: resize.screenLayout(30, context),

            )
        ),
      ),
      body: SingleChildScrollView(
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
                  Text(widget.name,
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
                  Text(widget.email,
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
                    child: Text(widget.leavesub,
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
                    child: Text(widget.leavereason,
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
                  Text(widget.dept,
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
                  Text(DateTime.parse(widget.fromDate).toString(),
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
                  Text(DateTime.parse(widget.toDate).toString(),
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
                  Text(widget.session1,
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
                  Text(widget.session2,
                    style: textStyle,)
                ],
              ),
              resize.verticalSpace(50, context),
              Row(
                children: [
                  resize.horizontalSpace(60, context),
                  Text('Total Days : ',
                    style: textStyle,
                  ),
                  resize.horizontalSpace(20, context),
                  Text(totalDays.toString(),
                    style: textStyle,)
                ],
              ),
              resize.verticalSpace(100, context),
              //text buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: color_mode.primaryColor,
                      backgroundColor: Colors.green,
                    ),
                    onPressed: (){
                      leaveApproved(widget.email,widget.days,widget.session1,widget.session2,widget.fromDate,widget.toDate);
                      Navigator.pop(context);
                    },
                    child: Text('Approve Leave',
                      style: TextStyle(color: color_mode.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: resize.screenLayout(29, context)
                      ),
                    ),),
                  //reject button
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: color_mode.primaryColor,
                      backgroundColor: Colors.red,
                    ),
                    onPressed: (){
                      leaveRejected(widget.email);
                    },
                    child: Text('Reject Leave',
                      style: TextStyle(color: color_mode.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: resize.screenLayout(29, context)
                      ),
                    ),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

