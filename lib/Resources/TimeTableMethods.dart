import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lms_staff/Models/TimeTable.dart';

class TimeTableMethods{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> timetablePublish({
    required final String subject1,
    required final String subject2,
    required final String subject3,
    required final String subject4,
    required final String subject5,
    required final String semester,
  }) async {
    String finalResult = "Some internal error occurred. Try again later.";

    try{
      TimeTableModel timeTableModel = TimeTableModel(
          subject1: subject1,
          subject2: subject2,
          subject3: subject3,
          subject4: subject4,
          subject5: subject5,
      );
      await _firestore.collection('TimeTable').doc(semester).set(timeTableModel.toJson(), SetOptions(merge: true));
      finalResult = "success";
      return finalResult;
    } catch(error) {
      finalResult = error.toString();
      return finalResult;
    }
}
}