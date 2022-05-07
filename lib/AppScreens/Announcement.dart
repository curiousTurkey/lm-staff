import 'package:flutter/material.dart';

import '../ReusableUtils/Appbar.dart';

class Announcement extends StatefulWidget {
  const Announcement({Key? key}) : super(key: key);

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Class Announcement'),
      body: const Center(
        child: Text('Announcement Page'),
      ),
    );
  }
}
