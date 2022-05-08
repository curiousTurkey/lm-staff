import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class StaffModel{
  final String fullName;
  final String emailAddress;
  final String password;
  late String userId;
  late String contactNo;
  late bool isClassTeacher;
  late String semClassTeacher;
  late String imageUrl;
  late String userType;
  final String deptName;
  late String firstSignin;
  double casualLeaveTaken;

  StaffModel({
    required this.fullName,
    required this.emailAddress,
    required this.password,
    this.userId = "not set",
    this.contactNo = "not set",
    required this.deptName,
    this.isClassTeacher = false,
    this.semClassTeacher = "null",
    this.imageUrl = "null",
    this.userType = 'staff',
    this.firstSignin = "true",
    this.casualLeaveTaken = 0,
});

  Map<String, dynamic> toJson() => {
    "name" : fullName,
    "email" : emailAddress,
    "password" : password,
    "userid" : userId,
    "contact" : contactNo,
    "isclassteacher" : isClassTeacher,
    "semclassteacher" : semClassTeacher,
    "imageurl" : imageUrl,
    "usertype" : userType,
    "dept" : deptName,
    "firstsignin" : firstSignin,
    "casualleavetaken" : casualLeaveTaken,

  };

  static StaffModel fromSnap(DocumentSnapshot snapshot){
    var snapShot = snapshot.data() as Map<String , dynamic>;
    return StaffModel(
      fullName: snapShot['name'],
      emailAddress: snapShot['email'],
      password: snapShot['password'],
      userId: snapShot['userid'],
      contactNo: snapShot['contact'],
      isClassTeacher : snapShot['isclassteacher'],
      semClassTeacher: snapShot['semclassteacher'],
      imageUrl: snapShot['imageurl'],
      userType: snapShot['usertype'],
      deptName: snapShot['dept'],
      firstSignin: snapShot['firstsignin'],
      casualLeaveTaken: snapShot['casualleavetaken']
    );
  }
  static StaffModel fromJsonAsync(AsyncSnapshot<DocumentSnapshot<Map<String,dynamic>>> json) => StaffModel(
      fullName: json.data!['fullname'],
  emailAddress: json.data!['email'],
  password: json.data!['password'],
  userId: json.data!['userid'],
  contactNo: json.data!['contact'],
  isClassTeacher : json.data!['isclassteacher'],
  semClassTeacher: json.data!['semclassteacher'],
  imageUrl: json.data!['imageurl'],
  userType: json.data!['usertype'],
  deptName: json.data!['dept'],
  firstSignin: json.data!['firstsignin'],
  casualLeaveTaken: json.data!['casualleavetaken']);

}
