import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lms_staff/Models/LeaveModel.dart';
import '../Models/StaffModel.dart';
import '../Resources/StaffAuthMethods.dart';



class StaffProvider with ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  StaffModel _staffModel = StaffModel(fullName: '', emailAddress: '', password: '', userId: '', contactNo: '', deptName: '');
  final StaffAuthMethod staffAuthMethod = StaffAuthMethod();
  StaffModel get getStaff => _staffModel;

  Future<void> refreshStaff() async {
    StaffModel staffModel = await staffAuthMethod.getStaffDetails();
    _staffModel = staffModel;
    notifyListeners();
  }

}