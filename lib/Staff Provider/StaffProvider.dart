import 'package:flutter/material.dart';
import '../Models/StaffModel.dart';
import '../Resources/StaffAuthMethods.dart';



class StaffProvider with ChangeNotifier{
  StaffModel _staffModel = StaffModel(fullName: '', emailAddress: '', password: '', userId: '', contactNo: '', deptName: '');
  final StaffAuthMethod staffAuthMethod = StaffAuthMethod();

  StaffModel get getStaff => _staffModel;

  Future<void> refreshStaff() async {
    StaffModel staffModel = await staffAuthMethod.getStaffDetails();
    _staffModel = staffModel;
    notifyListeners();
  }

}