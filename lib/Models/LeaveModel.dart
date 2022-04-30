import 'package:cloud_firestore/cloud_firestore.dart';

class StaffLeaveModel {
  final String fullName;
  final String dept;
  final String emailAddress;
  final String leaveSubject;
  final String leaveReason;
  final String fromDate;
  final String toDate;
  final String session1;
  final String session2;
  String isApproved;

  StaffLeaveModel({
  required this.fullName,
  required this.dept,
  required this.emailAddress,
  required this.leaveSubject,
  required this.leaveReason,
  required this.fromDate,
  required this.toDate,
  required this.session1,
  required this.session2,
    this.isApproved="no"
});

  Map<String,dynamic> toJson() => {
    "fullname" : fullName,
    "dept" : dept,
    "email" : emailAddress,
    "leavesub" : leaveSubject,
    "leavereason" : leaveReason,
    "fromdate" : fromDate,
    "todate" : toDate,
    "session1" : session1,
    "session2" : session2,
    "isapproved" : isApproved
  };

  static StaffLeaveModel fromSnap(DocumentSnapshot snapshot){
    var snapShot = snapshot.data() as Map<String,dynamic> ;
    return StaffLeaveModel(
        fullName: snapShot["fullname"],
        dept: snapShot["dept"],
        emailAddress: snapShot["email"],
        leaveSubject: snapShot["leavesub"],
        leaveReason: snapShot["leavereason"],
        fromDate: snapShot["fromdate"],
        toDate: snapShot["todate"],
        session1: snapShot["session1"],
        session2: snapShot["session2"],
        isApproved: snapShot["isapproved"],
    );
  }
}