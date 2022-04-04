import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lms_staff/Models/LeaveModel.dart';


class StaffLeave with ChangeNotifier{
   StaffLeaveModel _staffLeaveModel = StaffLeaveModel(
      fullName: '',
      dept: '',
      emailAddress: '',
      leaveSubject: '',
      leaveReason: '',
      fromDate: '',
      toDate: '',
      session1: '',
      session2: '',
   );
  StaffLeaveModel get getStaffLeave => _staffLeaveModel;

  Future<void> refreshStaff() async {
    StaffLeaveModel staffLeaveModel = await getStaffLeaveDetails();
    _staffLeaveModel = staffLeaveModel;
    notifyListeners();
  }


   Future<StaffLeaveModel> getStaffLeaveDetails() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
     var currentUser = auth.currentUser!;
     final FirebaseFirestore firestore = FirebaseFirestore.instance;
     String? emailAddress = currentUser.email;
     DocumentSnapshot snapshot = await firestore.collection('users').doc(emailAddress).collection('leave').doc().get();
     return StaffLeaveModel.fromSnap(snapshot);
   }
}
