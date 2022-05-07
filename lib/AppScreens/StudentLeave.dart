import 'package:flutter/material.dart';
import 'package:lms_staff/ReusableUtils/Appbar.dart';

class StudentLeave extends StatefulWidget {
  const StudentLeave({Key? key}) : super(key: key);

  @override
  State<StudentLeave> createState() => _StudentLeaveState();
}

class _StudentLeaveState extends State<StudentLeave> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Leave Approval'),
      body: const Center(
        child: Text('Leave Approval Student'),
      ),
    );
  }
}
