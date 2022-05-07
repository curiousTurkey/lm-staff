import 'package:flutter/material.dart';
import 'package:lms_staff/ReusableUtils/Appbar.dart';

class LeaveHistory extends StatefulWidget {
  const LeaveHistory({Key? key}) : super(key: key);

  @override
  State<LeaveHistory> createState() => _LeaveHistoryState();
}

class _LeaveHistoryState extends State<LeaveHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Leave History'),
      body: const Center(
        child: Text('Leave History'),
      ),
    );
  }
}
