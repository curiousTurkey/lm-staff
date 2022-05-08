import 'package:cloud_firestore/cloud_firestore.dart';

class TimeTableModel {
  final String subject1;
  final String subject2;
  final String subject3;
  final String subject4;
  final String subject5;
  TimeTableModel({
    required this.subject1,
    required this.subject2,
    required this.subject3,
    required this.subject4,
    required this.subject5,
});

  Map<String, dynamic> toJson() =>
      {
        "Subject 1" : subject1,
        "Subject 2" : subject2,
        "Subject 3" : subject3,
        "Subject 4" : subject4,
        "Subject 5" : subject5,
      };

  static TimeTableModel fromSnap(DocumentSnapshot snapshot) {
    var snapShot = snapshot.data() as Map<String, dynamic> ;
    return TimeTableModel(
      subject1: snapShot['Subject 1'],
      subject2: snapShot['Subject 2'],
      subject3: snapShot['Subject 3'],
      subject4: snapShot['Subject 4'],
      subject5: snapShot['Subject 5'],
    );
  }
}