import 'package:flutter/material.dart';

import '../ReusableUtils/Appbar.dart';

class LeaveStatus extends StatefulWidget {
  const LeaveStatus({Key? key}) : super(key: key);

  @override
  State<LeaveStatus> createState() => _LeaveStatusState();
}

class _LeaveStatusState extends State<LeaveStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Leave Status'),
      body: const Center(
        child: Text('Leave Status'),
      ),
    );
  }
}
