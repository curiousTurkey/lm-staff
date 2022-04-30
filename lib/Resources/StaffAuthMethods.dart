import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/StaffModel.dart';

class StaffAuthMethod{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<StaffModel> getStaffDetails() async {
    var currentUser = _auth.currentUser!;
    DocumentSnapshot snapshot = await _firestore.collection('users').doc(currentUser.email).get();
    return StaffModel.fromSnap(snapshot);
  }
  Future<String> loginStaff({
  required String emailAddress,
    required String password,
    required String userType,
}) async {
    String finalResult = "Database connection error";
    try{
      print("entered");
      DocumentSnapshot snapshot = await _firestore.collection('users').doc(emailAddress).get();
      String usertype = (snapshot.data() as Map<String,dynamic>)['usertype'];
      String email = (snapshot.data() as Map<String,dynamic>)['email'];
      String pass = (snapshot.data() as Map<String,dynamic>)['password'];
      if(snapshot.exists == false){
        print("doc dont exist exist");
        finalResult = "Staff user not found. Contact HOD";
      }
      else if(userType == usertype && emailAddress == email && password == pass){
        String firstSignin = (snapshot.data() as Map<String, dynamic>)['firstsignin'];
        if(firstSignin == "true"){
          _firestore.collection('users').doc(emailAddress).update({"firstsignin" : "false"});
          await _auth.createUserWithEmailAndPassword(email: emailAddress, password: password);
          return finalResult = "success";
        }
        else{
          await _auth.signInWithEmailAndPassword(email: emailAddress, password: password);
          return finalResult = "success";
        }
      }
      else{
        finalResult = "Staff not found";
      }
      return finalResult;

    }on FirebaseAuthException catch(error){
      return finalResult = error.toString();
    }
  } //login staff

 Future<String> logoutStaff() async {
    String finalResult = "Some error occurred";
    try {
      _auth.signOut();
      finalResult = "success";
      return finalResult;
    } on FirebaseAuthException catch(error){
      finalResult = error.toString();
      return finalResult;
    }
    await _auth.signOut();
 }
}