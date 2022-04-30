import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lms_staff/Models/LeaveModel.dart';

class StaffLeaveMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> applyLeave({
    required String fullName,
    required String dept,
    required String emailAddress,
    required String leaveSubject,
    required String leaveReason,
    required String fromDate,
    required String toDate,
    required String session1,
    required String session2,

}) async {
    String finalResult = "Database Connection error. Try again Later";
    try{

      StaffLeaveModel staffLeaveModel = StaffLeaveModel(
          fullName: fullName,
          dept: dept,
          emailAddress: emailAddress,
          leaveSubject: leaveSubject,
          leaveReason: leaveReason,
          fromDate: fromDate,
          toDate: toDate,
          session1: session1,
          session2: session2);
      await _firestore.collection('leave').doc().set(staffLeaveModel.toJson());
      finalResult = "success";

    }catch(error){
      finalResult = error.toString();
      return finalResult;
    }
    return finalResult;
  }
}