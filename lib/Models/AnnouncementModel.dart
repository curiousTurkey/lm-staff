import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementModel {
  final String subject;
  final String body;
  final String isStudent;
  final String isTeacher;
  final String date;
  final String announcerImage;
  final String announcerName;
  final String whichSem;

  AnnouncementModel({
    required this.subject,
    required this.body,
    required this.isStudent,
    this.isTeacher = "false",
    required this.date,
    required this.whichSem,
    required this.announcerImage,
    required this.announcerName,
  });

  Map<String, dynamic> toJson() =>
      {
        "announcername" : announcerName,
        "announcerImage" : announcerImage,
        "announcedate" : date,
        "isForTeacher" : isTeacher,
        "isForStudent" : isStudent,
        "announcebody" : body,
        "announcesub" : subject,
        "semester" : whichSem

      };

  static AnnouncementModel fromSnap(DocumentSnapshot snapshot) {
    var snapShot = snapshot.data() as Map<String, dynamic> ;
    return AnnouncementModel(
      subject: snapShot["announcesub"],
      body: snapShot["announcebody"],
      isStudent: snapShot["isForStudent"],
      isTeacher: snapShot["isForTeacher"],
      date: snapShot["announcedate"],
      announcerImage: snapShot["announcerImage"],
      announcerName: snapShot["announcername"],
      whichSem: snapShot["semester"],
    );
  }
}